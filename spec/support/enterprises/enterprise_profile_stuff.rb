# frozen_string_literal: true

shared_context 'enterprise_profile_stuff' do
  include RequestHelpers

  let(:role_admin) { FactoryBot.create(:role, :role_admin) }
  let(:role_manager) { FactoryBot.create(:role, :manager) }

  let(:entity_roles) {
    [
      FactoryBot.create(:entity_permission,
        role: role_admin,
        entity_type: Enterprise.name,
        can_read: true,
        can_write: true,
        can_destroy: true,
        can_change_status: true
      ),
      FactoryBot.create(:entity_permission,
        role: role_manager,
        entity_type: Enterprise.name,
        can_read: true,
        can_write: true,
        can_destroy: true,
        can_change_status: true
      )
    ]
  }

  let(:entity_roles_without_read) {
    [
      FactoryBot.create(:entity_permission,
        role: role_manager,
        entity_type: Enterprise.name
      )
    ]
  }

  let!(:user) { current_user }
  let!(:enterprise) { enterprise_helper }
  let!(:user_enterprise) { user_enterprise_helper }

  let(:user_role_manager) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_manager.id) }
end
