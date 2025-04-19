# frozen_string_literal: true

module Statuses
  class FineLegal < EnumerateIt::Base
    associate_values(
      fine_legal_assigned: 'fine-legal-assigned',
      fine_legal_closed: 'fine-legal-closed',
      fine_legal_pending: 'fine-legal-pending',
      fine_legal_rejected: 'fine-legal-rejected',
      fine_legal_paid: 'fine-legal-paid',
      fine_legal_claim: 'fine-legal-claim'
    )
  end
end
