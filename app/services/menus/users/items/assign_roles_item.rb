# frozen_string_literal: true

module Menus
  module Users
    module Items
      class AssignRolesItem < UserRoles::Import::Create::Policy
        def initialize(user:)
          super(current_user: user)
        end

        def perform
          {
            assignRoles: {
              code: 'assignRoles',
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
