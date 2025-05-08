# frozen_string_literal: true

RSpec.shared_context 'list_categories_stuff' do
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

  let(:category_fine_root) do
    entity_permissions

    FactoryBot.create(:category_fine,
                      name: 'Multas Generales',
                      description: 'Categoría principal de multas',
                      code: 'MG-001',
                      formula: 'valor_base * 1.0',
                      value: 100.0,
                      active: true,
                      created_by: current_user,
                      enterprise: enterprise)
  end

  let(:category_fine_child) do
    FactoryBot.create(:category_fine,
                      name: 'Multas por Ruido',
                      description: 'Multas por exceso de ruido',
                      code: 'MR-001',
                      formula: 'valor_base * 1.5',
                      value: 150.0,
                      active: true,
                      parent_category_fine: category_fine_root,
                      created_by: current_user,
                      enterprise: enterprise)
  end

  let(:category_fine_child_child) do
    FactoryBot.create(:category_fine,
                      name: 'Multas por Ruido hija',
                      description: 'Multas por exceso de ruido',
                      code: 'MR-002',
                      formula: 'valor_base * 1.5',
                      value: 150.0,
                      active: true,
                      parent_category_fine: category_fine_child,
                      created_by: current_user,
                      enterprise: enterprise)
  end

  let(:category_fine_inactive) do
    FactoryBot.create(:category_fine,
                      name: 'Multas Obsoletas',
                      description: 'Categoría inactiva',
                      code: 'MO-001',
                      formula: 'valor_base * 1.0',
                      value: 100.0,
                      active: false,
                      created_by: current_user,
                      enterprise: enterprise)
  end

  let(:category_fine_active) do
    FactoryBot.create(:category_fine,
                      name: 'Multas Obsoletas MA',
                      description: 'Categoría activa',
                      code: 'MA-001',
                      formula: 'valor_base * 1.0',
                      value: 100.0,
                      active: true,
                      created_by: current_user,
                      enterprise: enterprise)
  end

  before do
    category_fine_root
    category_fine_child
    category_fine_inactive
  end
end
