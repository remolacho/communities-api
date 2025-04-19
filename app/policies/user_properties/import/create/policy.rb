# frozen_string_literal: true

module UserProperties
  module Import
    module Create
      class Policy < BasePolicy
        def can_write!
          loudly do
            role?(:can_write)
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
