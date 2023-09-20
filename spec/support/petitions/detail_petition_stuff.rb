# frozen_string_literal: true

shared_context 'detail_petition_stuff' do
  include RequestHelpers

  let(:status_pending) { @status_pending ||= FactoryBot.create(:status, :petition_pending) }
  let(:status_resolved) { @status_resolved ||= FactoryBot.create(:status, :petition_resolved) }

  let(:user) { current_user }
  let(:user_enterprise) { user_enterprise_helper }
  let(:user_role){ FactoryBot.create(:user_role, user_id: user.id, role_id: role_council_member.id) }

  let(:user_2) { @user_2 ||= FactoryBot.create(:user) }
  let(:user_enterprise_petition) {  FactoryBot.create(:user_enterprise, user_id: user_2.id, enterprise_id: enterprise_helper.id, active: true) }

  let(:category) { @category ||= FactoryBot.create(:category_petition, :petition , enterprise: enterprise_helper) }


  let(:user_enterprise_answer) {
    @user_enterprise_answer ||= FactoryBot.create(:user_enterprise,
                                                  user_id: user_answer.id,
                                                  enterprise_id: enterprise_helper.id,
                                                  active: true)

  }

  let(:role_coexistence_member){ FactoryBot.create(:role, :coexistence_member) }
  let(:role_council_member){ FactoryBot.create(:role, :council_member) }

  let(:group_role) {
    group = FactoryBot.create(:group_role, :council_coexistence)

    FactoryBot.create(:group_role_relation, role: role_coexistence_member, group_role: group)
    FactoryBot.create(:group_role_relation, role: role_council_member, group_role: group)

    group
  }

  let(:petition) {
    user_enterprise_petition
    status_pending

    data = {
      title: "Test PQR",
      message: "message test 1",
      category_petition_id: category.id,
      group_role_id: group_role.id
    }

    ::Petitions::CreateService.new(user: user_2, data: data).call
  }
end
