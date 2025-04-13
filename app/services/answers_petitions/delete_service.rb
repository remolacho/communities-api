# frozen_string_literal: true

module AnswersPetitions
  class DeleteService
    attr_accessor :petition, :answer, :user

    def initialize(answer:, user:)
      @answer = answer
      @petition = answer.petition
      @user = user
    end

    def call
      raise PolicyException, I18n.t('services.answers_petitions.delete.not_allowed.status') if not_allowed_by_status?

      ActiveRecord::Base.transaction do
        petition.follow_petitions.create!(status_id: status.id,
                                          user_id: user.id,
                                          observation: answer.message)

        answer.destroy!
      end
    end

    private

    def not_allowed_by_status?
      petition.resolved? || petition.reviewing?
    end

    def status
      @status ||= Status.answer_deleted
    end
  end
end
