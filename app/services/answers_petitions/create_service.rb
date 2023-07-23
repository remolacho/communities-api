class AnswersPetitions::CreateService
  attr_accessor :petition, :user, :data

  def initialize(petition:, user:, data:)
    @petition = petition
    @user = user
    @data = data
  end

  def call
    raise ArgumentError, I18n.t("services.answers_petitions.create.data_empty") unless data.present?
    raise PolicyException, I18n.t('services.answers_petitions.create.is_resolved') if petition.resolved?
    raise PolicyException, I18n.t('services.answers_petitions.create.allowed_role') unless allowed_role?

    petition.answers_petitions.create!(allowed_data)
  end

  private

  def allowed_role?
    petition.user_id == user.id || (petition.roles.ids & user.roles.ids).any?
  end

  def allowed_data
    data.merge!(user_id: user.id)
  end
end
