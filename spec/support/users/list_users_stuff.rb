# frozen_string_literal: true

shared_context 'list_users_stuff' do
  include RequestHelpers

  let(:role_manager) { FactoryBot.create(:role, :manager) }
  let(:role_owner) { FactoryBot.create(:role, :owner) }

  let(:entity_roles) {
    [
      FactoryBot.create(:entity_permission,
        role: role_manager,
        entity_type: User.name,
        can_read: true,
        can_write: false,
        can_destroy: false,
        can_change_status: false
      ),
      FactoryBot.create(:entity_permission,
        role: role_owner,
        entity_type: User.name,
        can_read: false,
        can_write: false,
        can_destroy: false,
        can_change_status: false
      )
    ]
  }

  let(:user) { current_user }
  let(:enterprise) { enterprise_helper }
  let(:user_enterprise) { user_enterprise_helper }

  let(:user_roles_manager) {
    FactoryBot.create(:user_role, user_id: user.id, role_id: role_manager.id)
  }

  let(:user_roles_owner) {
      FactoryBot.create(:user_role, user_id: user.id, role_id: role_owner.id)
  }
end
