# frozen_string_literal: true

class Petitions::CreateService
  attr_accessor :user, :data
  def initialize(user:, data:)
    @user = user
    @data = data
  end

  def call
    raise ArgumentError, I18n.t("services.petitions.create.data_empty") unless data.present?

    petition = Petition.create!(allowed_data)
    petition.follow_petitions.create!(status_id: petition.status_id, user_id: petition.user_id)
    petition
  end

  private

  def allowed_data
    category_valid!
    group_role_valid!

    define_token
    define_ticket
    define_status
    define_user

    data
  end

  def category_valid!
    category = CategoryPetition.find_by(id: data[:category_petition_id])
    raise ActiveRecord::RecordNotFound, I18n.t('services.petitions.create.category_not_found') unless category.present?
  end

  def group_role_valid!
    role = GroupRole.find_by(id: data[:group_role_id])
    raise ActiveRecord::RecordNotFound, I18n.t('services.petitions.create.group_role_not_found') unless role.present?
  end

  def define_user
    data[:user_id] = user.id
  end

  def define_status
    status = Status.petition_pending
    raise ActiveRecord::RecordNotFound, I18n.t('services.petitions.create.status_not_found') unless status.present?

    data[:status_id] = status.id
  end

  def define_token
    data[:token] = SecureRandom.uuid
  end

  def define_ticket
    data[:ticket] = "#{user.enterprise.short_name}-#{user.id}-#{Time.now.strftime('%d%H%M%S')}#{rand(1..1000)}"
  end
end
