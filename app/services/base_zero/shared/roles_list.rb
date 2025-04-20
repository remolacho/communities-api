# frozen_string_literal: true

module BaseZero
  module Shared
    class RolesList
      class << self
        def all
          {
            super_admin: 'Super admin',
            admin: 'admin',
            owner_admin: 'Owner admin',
            owner: 'Owner',
            coexistence: 'Coexistence Member',
            council: 'Council Member',
            counter: 'counter',
            fiscal: 'fiscal',
            manager: 'President/Manager',
            collaborator: 'Collaborator',
            tenant: 'tenant',
            vigilant: 'vigilant'
          }
        end

        def admin_roles
          [:super_admin, :admin]
        end

        def owner_roles
          [:owner_admin, :owner]
        end

        def council_roles
          [:council, :coexistence]
        end

        def management_roles
          [:counter, :fiscal, :manager]
        end

        def basic_roles
          [:collaborator, :tenant, :vigilant]
        end
      end
    end
  end
end
