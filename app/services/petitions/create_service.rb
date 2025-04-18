# frozen_string_literal: true

module Petitions
  class CreateService
    attr_accessor :user, :data

    def initialize(user:, data:)
      @user = user
      @data = data.to_h.deep_symbolize_keys
    end

    def call
      raise ArgumentError, I18n.t('services.petitions.create.data_empty') unless data.present?

      ActiveRecord::Base.transaction do
        files    = validate_attach_files_service.call
        petition = Petition.create!(allowed_data)
        petition.follow_petitions.create!(status_id: petition.status_id, user_id: petition.user_id)
        petition.files.attach(files) if files.present?
        petition
      end
    end

    private

    def allowed_data
      category_valid!
      group_role_valid!

      define_token
      define_ticket
      define_status
      define_user
      define_files
    end

    def category_valid!
      category = CategoryPetition.find_by(id: data[:category_petition_id])
      return if category.present?

      raise ActiveRecord::RecordNotFound,
            I18n.t('services.petitions.create.category_not_found')
    end

    def group_role_valid!
      role = GroupRole.find_by(id: data[:group_role_id])
      raise ActiveRecord::RecordNotFound, I18n.t('services.petitions.create.group_role_not_found') unless role.present?
    end

    def define_user
      data[:user_id] = user.id
      data
    end

    def define_status
      status = Status.petition_pending
      raise ActiveRecord::RecordNotFound, I18n.t('services.petitions.create.status_not_found') unless status.present?

      data[:status_id] = status.id
      data
    end

    def define_token
      data[:token] = SecureRandom.uuid
      data
    end

    def define_ticket
      data[:ticket] = "#{user.enterprise.short_name}-#{user.id}-#{Time.now.strftime('%d%H%M%S')}#{rand(1..1000)}"
      data
    end

    def define_files
      data.except(:files)
    end

    def validate_attach_files_service
      ValidateAttachFilesService.new(data: data, max_files: Petition::MAX_FILES)
    end
  end
end
