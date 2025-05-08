# frozen_string_literal: true

shared_context 'change_status_stuff' do
  include RequestHelpers

  let(:role_admin) { FactoryBot.create(:role, :role_admin) }
  let(:role_manager) { FactoryBot.create(:role, :manager) }
  let(:role_owner) { FactoryBot.create(:role, :owner) }

  # Permisos de entidad para los diferentes roles
  let(:entity_roles) {
    [
      # Admin tiene todos los permisos incluyendo activación
      FactoryBot.create(:entity_permission,
        role: role_admin,
        entity_type: User.name,
        can_read: true,
        can_write: true,
        can_destroy: true,
        can_change_status: true
      ),
      # Manager puede ver pero no activar
      FactoryBot.create(:entity_permission,
        role: role_manager,
        entity_type: User.name,
        can_read: true,
        can_write: false,
        can_destroy: false,
        can_change_status: false
      ),
      # Owner puede ver pero no activar
      FactoryBot.create(:entity_permission,
        role: role_owner,
        entity_type: User.name,
        can_read: true,
        can_write: false,
        can_destroy: false,
        can_change_status: false
      )
    ]
  }

  let(:user) { current_user }
  let(:enterprise) { enterprise_helper }
  let(:user_enterprise) { user_enterprise_helper }

  # Roles asignados al usuario de prueba
  let!(:user_roles) {
    [
      FactoryBot.create(:user_role, user_id: user.id, role_id: role_owner.id)
    ]
  }

  let(:user_role_admin) {
    [
      FactoryBot.create(:user_role, user_id: user.id, role_id: role_admin.id)
    ]
  }

  let(:user_role_manager) {
    [
      FactoryBot.create(:user_role, user_id: user.id, role_id: role_manager.id)
    ]
  }

  let(:user_to_change) { FactoryBot.create(:user) }
  let(:user_enterprise_to_change) {
    FactoryBot.create(:user_enterprise,
      user_id: user_to_change.id,
      enterprise_id: enterprise.id,
      active: true
    )
  }
end
