# frozen_string_literal: true

class Suggestions::CreateService
  attr_accessor :user, :data

  def initialize(user:, data:)
    @user = user
    @data = data.to_h.deep_symbolize_keys
  end

  def call
    raise ArgumentError, I18n.t('services.suggestions.create.data_empty') unless data.present?

    ActiveRecord::Base.transaction do
      files      = validate_attach_files_service.call
      suggestion = Suggestion.create!(allowed_data)
      suggestion.files.attach(files) if files.present?
      suggestion
    end
  end

  private

  def allowed_data
    define_token
    define_ticket
    define_user
    define_files
  end

  def define_user
    data[:user_id] = user.id
    data
  end

  def define_token
    data[:token] = SecureRandom.uuid
    data
  end

  def define_ticket
    data[:ticket] = "SUG-#{Time.now.strftime('%d%H%M%S')}#{rand(1..10_000)}"
    data
  end

  def define_files
    data.reject { |k, _| k == :files }
  end

  def validate_attach_files_service
    Suggestions::ValidateAttachFilesService.new(data: data, max_files: Suggestion::MAX_FILES)
  end
end
