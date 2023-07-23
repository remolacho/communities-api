class Status
  module AnswerStatustable
    extend ActiveSupport::Concern

    ANSWER = 'answer'
    ANSWER_DELETE = 'ans-deleted'

    included do
      scope :answer_deleted, -> {
        find_by(status_type: ANSWER, code: ANSWER_DELETE)
      }
    end
  end
end
