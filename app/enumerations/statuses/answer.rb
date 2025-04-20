# frozen_string_literal: true

module Statuses
  class Answer < EnumerateIt::Base
    associate_values(
      answer_deleted: 'ans-deleted'
    )
  end
end
