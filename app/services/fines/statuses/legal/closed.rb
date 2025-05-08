# frozen_string_literal: true

module Fines
  module Statuses
    module Legal
      class Closed < ::Fines::Statuses::Base
        private

        # override
        def statuses
          if policy.can_change_status?
            return [
              Status.fine_legal_paid,
              Status.fine_legal_pending,
              Status.fine_legal_claim
            ]
          end

          return [Status.fine_legal_closed] if creator? || owner?

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
