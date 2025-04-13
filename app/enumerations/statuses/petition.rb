# frozen_string_literal: true

module Statuses
  class Petition < EnumerateIt::Base
    associate_values(
      petition_pending: 'pet-pending',
      petition_reviewing: 'pet-reviewing',
      petition_rejected: 'pet-rejected',
      petition_confirm: 'pet-confirm',
      petition_rejected_solution: 'pet-rejected-solution',
      petition_resolved: 'pet-resolved'
    )
  end
end
