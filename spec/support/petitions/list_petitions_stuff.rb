shared_context 'list_petitions_stuff' do
  include RequestHelpers

  let(:enterprise) { enterprise_helper }
  let(:user) { current_user }
  let(:user_enterprise) { user_enterprise_helper }

  let(:role_manager) {
    FactoryBot.create(:role, :manager)
  }

  let(:role_committee) {
    FactoryBot.create(:role, :committee_member)
  }

  let(:user_roles_manager){
      FactoryBot.create(:user_role, user_id: user.id, role_id: role_manager.id)
  }

  let(:user_roles_committee){
    FactoryBot.create(:user_role, user_id: user.id, role_id: role_committee.id)
  }

  let(:filter){
    {
      status_id: 1,
      category_petition_id: 1
    }
  }
end
