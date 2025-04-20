# frozen_string_literal: true

module UserRoles
  module Import
    module Remove
      class Policy < BasePolicy
        def can_write!
          loudly do
            role?(:can_destroy)
          end
        end

        private

        # override
        def entity
          @entity ||= UserRole.name
        end
      end
    end
  end
end
