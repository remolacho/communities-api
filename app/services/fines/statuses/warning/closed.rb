# frozen_string_literal: true

module Fines
  module Statuses
    module Warning
      class Closed < ::Fines::Statuses::Base
        private

        # override
        def statuses
          if policy.can_change_status?
            return [
              Status.fine_warning_finished,
              Status.fine_warning_assigned
            ]
          end

          return [Status.fine_warning_closed] if creator? || owner?

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
