# frozen_string_literal: true

shared_context 'detail_suggestion_stuff' do
  include RequestHelpers

  let(:role_admin){ FactoryBot.create(:role, :role_admin) }
  let(:role_manager){ FactoryBot.create(:role, :manager) }
  let(:role_owner){ FactoryBot.create(:role, :owner) }

  let(:show_suggestion) { FactoryBot.create(:group_role, :show_suggestion) }

  let(:group_role_relations) {
    [FactoryBot.create(:group_role_relation, role: role_admin, group_role: show_suggestion),
     FactoryBot.create(:group_role_relation, role: role_manager, group_role: show_suggestion)]
  }

  let(:enterprise) { enterprise_helper }

  let(:user) { current_user }
  let(:user_enterprise) { user_enterprise_helper }
  let(:user_role_manager) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_manager.id) }
  let(:user_role_owner) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_owner.id) }

  let(:user_suggestion) { FactoryBot.create(:user) }
  let(:user_enterprise_suggestion) {  FactoryBot.create(:user_enterprise, user_id: user_suggestion.id, enterprise_id: enterprise_helper.id, active: true) }
  let(:user_suggestion_role_owner) { FactoryBot.create(:user_role, user_id: user_suggestion.id, role_id: role_owner.id) }

  let(:suggestion) {
    group_role_relations
    user_enterprise_suggestion
    user_suggestion_role_owner

    data = {
      message: "message test 1",
    }

    ::Suggestions::CreateService.new(user: user_suggestion, data: data).call
  }

  let(:suggestion_2) {
    group_role_relations
    user_enterprise
    user_role_owner

    data = {
      message: "message test 1",
    }

    ::Suggestions::CreateService.new(user: user, data: data).call
  }
end
