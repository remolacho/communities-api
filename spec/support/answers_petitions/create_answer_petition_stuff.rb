# frozen_string_literal: true

shared_context 'create_answer_petition_stuff' do
  include RequestHelpers

  let(:status_pending) { @status_pending ||= FactoryBot.create(:status, :petition_pending) }
  let(:status_resolved) { @status_resolved ||= FactoryBot.create(:status, :petition_resolved) }
  let(:user_enterprise) { user_enterprise_helper }

  let(:user) { current_user }
  let(:category) { @category ||= FactoryBot.create(:category_petition, :petition , enterprise: enterprise_helper) }

  let(:user_answer) { @user_answer ||= FactoryBot.create(:user) }

  let(:user_enterprise_answer) {
    @user_enterprise_answer ||= FactoryBot.create(:user_enterprise,
                                           user_id: user_answer.id,
                                           enterprise_id: enterprise_helper.id,
                                           active: true)

  }

  let(:role1){ FactoryBot.create(:role, :coexistence_member) }
  let(:role2){ FactoryBot.create(:role, :committee_member) }

  let(:group_role) {
    group = FactoryBot.create(:group_role, :coexistence_committee)

    FactoryBot.create(:group_role_relation, role: role1, group_role: group)
    FactoryBot.create(:group_role_relation, role: role2, group_role: group)

    group
  }

  let(:petition) {
    status_pending

    data = {
      title: "Test PQR",
      message: "message test 1",
      category_petition_id: category.id,
      group_role_id: group_role.id
    }

    ::Petitions::CreateService.new(user: user, data: data).call
  }

  let(:user_role_answer){
    FactoryBot.create(:user_role, user_id: user_answer.id, role_id: role2.id)
  }
end
