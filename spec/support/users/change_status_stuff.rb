shared_context 'change_status_stuff' do
  include RequestHelpers

  let(:enterprise) { enterprise_helper }
  let(:user) { current_user }
  let(:user_enterprise) { user_enterprise_helper }

  let(:role_manager) {
    FactoryBot.create(:role, :manager)
  }

  let(:role_owner) {
    FactoryBot.create(:role, :owner)
  }

  let(:role_admin) {
    FactoryBot.create(:role, :role_admin)
  }

  let!(:user_roles){
    [
      FactoryBot.create(:user_role, user_id: user.id, role_id: role_manager.id),
      FactoryBot.create(:user_role, user_id: user.id, role_id: role_owner.id)
    ]
  }

  let(:user_role_admin){
    [
      FactoryBot.create(:user_role, user_id: user.id, role_id: role_admin.id),
    ]
  }

  let(:user_to_change) { FactoryBot.create(:user) }
  let(:user_enterprise_to_change) { FactoryBot.create(:user_enterprise, user_id: user_to_change.id, enterprise_id: enterprise.id, active: true) }
end
