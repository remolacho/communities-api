# frozen_string_literal: true

module StatusesPetitions
  module List
    module Factory
      class Confirm < Base
        private

        # override
        def statuses
          return [Status.petition_reviewing] unless owner?

          [
            Status.petition_rejected_solution,
            Status.petition_resolve
          ]
        end

        # override
        def can_view?
          owner? || (petition.roles.ids & user.roles.ids).any?
        end

        def owner?
          user.id == petition.user_id
        end
      end
    end
  end
end
