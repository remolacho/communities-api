# frozen_string_literal: true

shared_context 'enterprise_profile_stuff' do
  include RequestHelpers

  let(:role_admin){ FactoryBot.create(:role, :role_admin) }
  let(:role_manager){ FactoryBot.create(:role, :manager) }

  let(:group_show_enterprise) { FactoryBot.create(:group_role, :show_enterprise) }

  let(:group_role_relations) {
    [FactoryBot.create(:group_role_relation, role: role_admin, group_role: group_show_enterprise),
     FactoryBot.create(:group_role_relation, role: role_manager, group_role: group_show_enterprise)]
  }

  let!(:user) { current_user }
  let!(:enterprise) { enterprise_helper }
  let!(:user_enterprise) { user_enterprise_helper }

  let(:user_role_manager) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_manager.id) }
end
