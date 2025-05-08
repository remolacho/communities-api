# frozen_string_literal: true

module Fines
  module Statuses
    module Legal
      class Paid < ::Fines::Statuses::Base
        private

        # override
        def statuses
          [Status.fine_legal_paid]
        end

        # override
        def can_view?
          policy.can_change_status? || creator? || owner?
        end
      end
    end
  end
end
