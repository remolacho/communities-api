# frozen_string_literal: true

module StatusesPetitions
  module List
    module Factory
      class RejectedSolution < Base
        private

        # override
        def statuses
          return [Status.petition_confirm] if owner?

          [
            Status.petition_pending,
            Status.petition_reviewing
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
