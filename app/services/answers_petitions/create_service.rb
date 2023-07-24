class AnswersPetitions::CreateService
  attr_accessor :petition, :user, :data

  def initialize(petition:, user:, data:)
    @petition = petition
    @user = user
    @data = data
  end

  def call
    has_data!
    policy.can_write!
    allow_state!

    petition.answers_petitions.create!(allowed_data)
  end

  private

  def has_data!
    raise ArgumentError, I18n.t("services.answers_petitions.create.data_empty") unless data.present?
  end

  def policy
    ::Petitions::Policy.new(current_user: user, petition: petition)
  end

  def allow_state!
    raise PolicyException, I18n.t('services.answers_petitions.create.is_resolved') if petition.resolved?
  end

  def allowed_data
    data.merge!(user_id: user.id)
  end
end
