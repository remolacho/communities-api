# frozen_string_literal: true

module Fines
  module Statuses
    module Legal
      class Rejected < ::Fines::Statuses::Base
        private

        # override
        def statuses
          if policy.can_change_status?
            return [
              Status.fine_legal_assigned,
              Status.fine_legal_paid,
              Status.fine_legal_pending
            ]
          end

          return [Status.fine_legal_rejected] if creator? || owner?

          []
        end

        # override
        def can_view?
          policy.can_change_status? || creator? || owner?
        end
      end
    end
  end
end
