# frozen_string_literal: true

module Menus
  module Settings
    module Items
      class RemoveRolesItem < UserRoles::Import::Remove::Policy
        def initialize(user:)
          super(current_user: user)
        end

        def perform
          {
            remove_user_roles: {
              code: 'remove_user_roles',
              show: can_show?
            }
          }
        end

        private

        def can_show?
          @can_show ||= role?(:can_read)
        end
      end
    end
  end
end
