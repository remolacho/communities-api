# frozen_string_literal: true

module Menus
  module Users
    module Items
      class RemoveRolesItem < UserRoles::Import::Remove::Policy
        def initialize(user:)
          super(current_user: user)
        end

        def perform
          {
            removeRoles: {
              code: 'removeRoles',
              show: can_show?
            }
          }
        end

        private

        def can_show?
          @can_show ||= has_role?
        end
      end
    end
  end
end
