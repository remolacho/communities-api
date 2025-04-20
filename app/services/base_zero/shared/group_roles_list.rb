# frozen_string_literal: true

module BaseZero
  module Shared
    class GroupRolesList
      class << self
        def all
          [
            { code: 'all', name: { es: 'Todos los miembros' }, entity_type: Petition::ENTITY_TYPE },
            { code: 'admin_manager', name: { es: 'Administración y Presidente' }, entity_type: Petition::ENTITY_TYPE },
            { code: 'all_admin', name: { es: 'Administración' }, entity_type: Petition::ENTITY_TYPE },
            { code: 'admin_coexistence', name: { es: 'Administración y Comité' }, entity_type: Petition::ENTITY_TYPE },
            { code: 'admin_council', name: { es: 'Administración y Consejo' }, entity_type: Petition::ENTITY_TYPE },
            { code: 'council_coexistence', name: { es: 'Consejo y Comité' }, entity_type: Petition::ENTITY_TYPE },
            { code: 'admin', name: { es: 'Administrador' }, entity_type: Petition::ENTITY_TYPE },
            { code: 'coexistence', name: { es: 'Comité de convivencia' }, entity_type: Petition::ENTITY_TYPE },
            { code: 'council', name: { es: 'Consejo' }, entity_type: Petition::ENTITY_TYPE },
            { code: 'fiscal', name: { es: 'Fiscal' }, entity_type: Petition::ENTITY_TYPE },
            { code: 'counter', name: { es: 'Contador' }, entity_type: Petition::ENTITY_TYPE }
          ]
        end

        def relations
          {
            petitions: {
              all: [:super_admin, :admin, :coexistence, :council, :manager, :counter, :fiscal],
              all_admin: [:super_admin, :admin, :counter, :fiscal],
              admin_manager: [:super_admin, :admin, :manager],
              admin_coexistence: [:super_admin, :admin, :coexistence],
              admin_council: [:super_admin, :admin, :council],
              council_coexistence: [:super_admin, :coexistence, :council],
              admin: [:super_admin, :admin],
              council: [:super_admin, :council],
              coexistence: [:super_admin, :coexistence],
              fiscal: [:super_admin, :fiscal],
              counter: [:super_admin, :counter]
            }
          }
        end
      end
    end
  end
end
