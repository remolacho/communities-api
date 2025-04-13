# frozen_string_literal: true

module StatusesPetitions
  module List
    module Factory
      class Reviewing < Base
        private

        def serializer
          ActiveModelSerializers::SerializableResource.new(statuses,
                                                           each_serializer: ::Statuses::DetailSerializer).as_json
        end

        # override
        def statuses
          [
            Status.petition_pending,
            Status.petition_confirm
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
