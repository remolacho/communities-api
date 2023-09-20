class AnswersPetitions::CreateService
  attr_accessor :petition, :user, :data, :user_petition

  def initialize(petition:, user:, data:)
    @petition = petition
    @user = user
    @data = data.to_h.deep_symbolize_keys
    @user_petition = petition.user
  end

  def call
    has_data!
    policy.can_write!
    allow_state!

    ActiveRecord::Base.transaction do
      files = validate_attach_files_service.call
      answer = petition.answers_petitions.create!(allowed_data)
      answer.files.attach(files) if files.present?
      notification(answer)

      answer
    end
  end

  private

  def notification(answer)
    return unless allowed_mail?

    AnswerPetitionMailer.notify(user: user_petition,
                                enterprise: user.enterprise ,
                                petition: petition,
                                answer: answer).deliver_now!
  end

  def allowed_mail?
    user.id != user_petition.id
  end

  def has_data!
    raise ArgumentError, I18n.t("services.answers_petitions.create.data_empty") unless data.present?
  end

  def policy
    ::AnswersPetitions::Policy.new(current_user: user, petition: petition)
  end

  def allow_state!
    raise PolicyException, I18n.t('services.answers_petitions.create.is_resolved') if petition.resolved?
  end

  def allowed_data
    data.merge!(user_id: user.id)
    data.reject{ |k, _| k == :files }
  end

  def validate_attach_files_service
    ::Petitions::ValidateAttachFilesService.new(data: data, max_files: AnswersPetition::MAX_FILES)
  end
end
