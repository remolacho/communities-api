# frozen_string_literal: true

shared_context 'user_profile_stuff' do
  include RequestHelpers

  let(:role_owner) { FactoryBot.create(:role, :owner) }
  let(:role_admin) { FactoryBot.create(:role, :role_admin) }

  # Permisos de entidad para los diferentes roles
  let(:entity_roles) {
    [
      # Admin puede ver todos los perfiles
      FactoryBot.create(:entity_permission,
        role: role_admin,
        entity_type: User.name,
        can_read: true,
        can_write: true,
        can_destroy: true,
        can_change_status: true
      ),
      # Owner tiene permisos limitados
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

  # Usuario principal y su empresa
  let(:user) { current_user }
  let(:enterprise) { enterprise_helper }
  let(:user_enterprise) { user_enterprise_helper }
  let(:user_role_admin) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_admin.id) }

  # Usuario secundario para pruebas
  let(:user_other) { FactoryBot.create(:user) }
  let(:user_enterprise_other) {
    FactoryBot.create(:user_enterprise,
      user_id: user_other.id,
      enterprise_id: enterprise_helper.id,
      active: true
    )
  }
  let(:user_role_owner_other) {
    FactoryBot.create(:user_role,
      user_id: user_other.id,
      role_id: role_owner.id
    )
  }
end
