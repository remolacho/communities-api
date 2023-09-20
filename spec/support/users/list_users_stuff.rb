shared_context 'list_users_stuff' do
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

  let(:listed_users) { FactoryBot.create(:group_role, :listed_users) }

  let(:group_role_relations) {
    [FactoryBot.create(:group_role_relation, role: role_manager, group_role: listed_users)]
  }

  let!(:user_roles){
    [
      FactoryBot.create(:user_role, user_id: user.id, role_id: role_manager.id),
      FactoryBot.create(:user_role, user_id: user.id, role_id: role_owner.id)
    ]
  }
end
