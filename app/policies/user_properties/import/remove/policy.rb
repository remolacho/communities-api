# frozen_string_literal: true

module UserProperties
  module Import
    module Remove
      class Policy < BasePolicy
        def can_destroy!
          loudly do
            role?(:can_destroy)
          end
        end

        private

        # override
        def entity
          @entity ||= UserProperty.name
        end
      end
    end
  end
end
