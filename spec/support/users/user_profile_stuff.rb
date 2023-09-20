# frozen_string_literal: true

shared_context 'user_profile_stuff' do
  include RequestHelpers

  let(:role_owner){ FactoryBot.create(:role, :owner) }
  let(:role_admin){ FactoryBot.create(:role, :role_admin) }
  let(:show_user) { FactoryBot.create(:group_role, :show_user) }

  let(:group_role_relations) {
    [FactoryBot.create(:group_role_relation, role: role_admin, group_role: show_user)]
  }

  let(:user) { current_user }
  let(:enterprise) { enterprise_helper }
  let(:user_enterprise) { user_enterprise_helper }
  let(:user_role_admin) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_admin.id) }

  let(:user_other) { FactoryBot.create(:user) }
  let(:user_enterprise_other) {  FactoryBot.create(:user_enterprise, user_id: user_other.id, enterprise_id: enterprise_helper.id, active: true) }
  let(:user_suggestion_role_other) { FactoryBot.create(:user_role, user_id: user_other.id, role_id: role_owner.id) }
end
