# frozen_string_literal: true

module Fines
  module Statuses
    module Warning
      class Assigned < ::Fines::Statuses::Base
        private

        # override
        def statuses
          if policy.can_change_status?
            return [
              Status.fine_warning_finished,
              Status.fine_warning_closed
            ]
          end

          return [Status.fine_warning_assigned] if creator? || owner?

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
