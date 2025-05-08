# frozen_string_literal: true

module Fines
  module Statuses
    module Warning
      class Finished < ::Fines::Statuses::Base
        private

        # override
        def statuses
          [Status.fine_warning_finished]
        end

        # override
        def can_view?
          policy.can_change_status? || creator? || owner?
        end
      end
    end
  end
end
