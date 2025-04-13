# frozen_string_literal: true

shared_context 'delete_answer_petition_stuff' do
  include RequestHelpers

  let!(:status_pending) { @status_pending ||= FactoryBot.create(:status, :petition_pending) }
  let!(:status_resolved) { @status_resolved ||= FactoryBot.create(:status, :petition_resolved) }
  let!(:status_answer_delete) { @status_answer_delete ||= FactoryBot.create(:status, :answer_delete) }

  let(:user_enterprise) { user_enterprise_helper }

  let(:user) { current_user }
  let(:user_answer) { @user_answer ||= FactoryBot.create(:user) }

  let(:user_enterprise_answer) {
    @user_enterprise_answer ||= FactoryBot.create(:user_enterprise,
                                                  user_id: user_answer.id,
                                                  enterprise_id: enterprise_helper.id,
                                                  active: true)
  }


  let(:category) { @category ||= FactoryBot.create(:category_petition, :petition , enterprise: enterprise_helper) }

  let(:role_coexistence_member){ FactoryBot.create(:role, :coexistence_member) }
  let(:role_council_member){ FactoryBot.create(:role, :council_member) }

  let!(:entity_permissions) do
    [
      FactoryBot.create(:entity_permission,
        role: role_coexistence_member,
        entity_type: AnswersPetition.name,
        can_destroy: true),
      FactoryBot.create(:entity_permission,
        role: role_council_member,
        entity_type: AnswersPetition.name,
        can_destroy: false)
    ]
  end

  let(:user_role_coexistence) {
    FactoryBot.create(:user_role, user_id: user.id, role_id: role_coexistence_member.id)
  }

  let(:user_role_council) {
    FactoryBot.create(:user_role, user_id: user.id, role_id: role_council_member.id)
  }

  let(:user_answer_role_council){
    FactoryBot.create(:user_role, user_id: user_answer.id, role_id: role_council_member.id)
  }

  let(:group_role) {
    group = FactoryBot.create(:group_role, :council_coexistence)

    FactoryBot.create(:group_role_relation, role: role_coexistence_member, group_role: group)
    FactoryBot.create(:group_role_relation, role: role_council_member, group_role: group)

    group
  }

  let(:petition) {
    FactoryBot.create(:petition,
      title: "Test PQR",
      message: "This is a test message for the petition",
      category_petition: category,
      group_role: group_role,
      status: status_pending,
      token: SecureRandom.uuid,
      ticket: "PQR-#{Time.current.to_i}",
      user: user_answer)
  }

  let(:answer) {
    FactoryBot.create(:answers_petition,
      message: "message test 1",
      petition: petition,
      user: user_answer)
  }

  let(:answer2) {
    FactoryBot.create(:answers_petition,
      message: "message test 2",
      petition: petition,
      user: user)
  }
end
