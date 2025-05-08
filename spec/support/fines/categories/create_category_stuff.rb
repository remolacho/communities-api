# frozen_string_literal: true

RSpec.shared_context 'create_category_stuff' do
  include RequestHelpers

  let(:role_admin) { FactoryBot.create(:role, :role_admin) }
  let(:role_coexistence_member) { FactoryBot.create(:role, :coexistence_member) }

  let(:entity_permissions) {
    [
      FactoryBot.create(:entity_permission,
        role: role_admin,
        entity_type: CategoryFine.name,
        can_read: true,
        can_write: true,
        can_destroy: true,
        can_change_status: true
      ),
      FactoryBot.create(:entity_permission,
        role: role_coexistence_member,
        entity_type: CategoryFine.name,
        can_read: false,
        can_write: false,
        can_destroy: false,
        can_change_status: false
      )
    ]
  }

  let(:enterprise) { enterprise_helper }
  let(:user) { current_user }
  let(:user_enterprise) { user_enterprise_helper }

  let(:user_role_admin) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_admin.id) }
  let(:user_role_coexistence_member) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_coexistence_member.id) }

  let(:parent_category) do
    entity_permissions

    FactoryBot.create(:category_fine,
      name: 'Categoría Padre',
      code: 'CP-001',
      description: 'Categoría padre para pruebas',
      formula: 'valor_base * 1.0',
      value: 100.0,
      created_by: user,
      enterprise: enterprise
    )
  end

  let(:valid_attributes) do
    {
      name: 'Nueva Categoría',
      code: 'NC-001',
      description: 'Descripción de la nueva categoría',
      formula: 'valor_base * 2.0',
      value: 200.0,
      active: true
    }
  end

  let(:valid_attributes_with_parent) do
    valid_attributes.merge(parent_category_fine_id: parent_category.id)
  end

  let(:invalid_attributes) do
    {
      name: '',  # name es requerido
      code: '',  # code es requerido
    }
  end

  let(:duplicate_code_attributes) do
    {
      name: 'Otra Categoría',
      code: parent_category.code, # código duplicado
      description: 'Esta categoría tendrá un código duplicado'
    }
  end

  before do
    parent_category
  end
end
