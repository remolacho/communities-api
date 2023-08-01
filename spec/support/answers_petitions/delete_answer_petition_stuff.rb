# frozen_string_literal: true

shared_context 'delete_answer_petition_stuff' do
  include RequestHelpers

  let!(:status_pending) { @status_pending ||= FactoryBot.create(:status, :petition_pending) }
  let!(:status_resolved) { @status_resolved ||= FactoryBot.create(:status, :petition_resolved) }
  let!(:status_answer_delete) { @status_answer_delete ||= FactoryBot.create(:status, :answer_delete) }


  let(:user_enterprise) { user_enterprise_helper }

  let(:user) { current_user }

  let(:category) { @category ||= FactoryBot.create(:category_petition, :petition , enterprise: enterprise_helper) }

  let(:role1){ FactoryBot.create(:role, :coexistence_member) }
  let(:role2){ FactoryBot.create(:role, :committee_member) }

  let(:group_role) {
    group = FactoryBot.create(:group_role, :coexistence_committee)

    FactoryBot.create(:group_role_relation, role: role1, group_role: group)
    FactoryBot.create(:group_role_relation, role: role2, group_role: group)

    group
  }

  let(:petition) {
    data = {
      title: "Test PQR",
      message: "message test 1",
      category_petition_id: category.id,
      group_role_id: group_role.id
    }

    ::Petitions::CreateService.new(user: user, data: data).call
  }

  let(:answer) {
    data = {
      message: "message test 1",
    }

    ::AnswersPetitions::CreateService.new(petition: petition, user: user, data: data).call
  }

  let(:user_answer) { @user_answer ||= FactoryBot.create(:user) }

  let(:user_enterprise_answer) {
    @user_enterprise_answer ||= FactoryBot.create(:user_enterprise,
                                                  user_id: user_answer.id,
                                                  enterprise_id: enterprise_helper.id,
                                                  active: true)

  }

  let(:user_role_answer){
    FactoryBot.create(:user_role, user_id: user_answer.id, role_id: role2.id)
  }

  let(:answer2) {
    user_enterprise_answer
    user_role_answer

    data = {
      message: "message test 2",
    }

    ::AnswersPetitions::CreateService.new(petition: petition, user: user_answer, data: data).call
  }
end
