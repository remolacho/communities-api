# frozen_string_literal: true

module StatusesPetitions
  module List
    module Factory
      class Pending < Base
        private

        # override
        def statuses
          [
            Status.petition_reviewing,
            Status.petition_rejected
          ]
        end

        # override
        def can_view?
          (petition.roles.ids & user.roles.ids).any?
        end
      end
    end
  end
end
