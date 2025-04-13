# frozen_string_literal: true

shared_context 'list_answers_petition_stuff' do
  include RequestHelpers

  let(:status_pending) { @status_pending ||= FactoryBot.create(:status, :petition_pending) }
  let(:role_coexistence_member){ FactoryBot.create(:role, :coexistence_member) }
  let(:role_council_member){ FactoryBot.create(:role, :council_member) }
  let(:category) { @category ||= FactoryBot.create(:category_petition, :petition , enterprise: enterprise_helper) }

  let(:user) { current_user }
  let(:user_enterprise) { user_enterprise_helper }
  let(:user_role){ FactoryBot.create(:user_role, user_id: user.id, role_id: role_council_member.id) }

  let(:user_2) { @user_2 ||= FactoryBot.create(:user) }
  let(:user_enterprise_petition) {  FactoryBot.create(:user_enterprise, user_id: user_2.id, enterprise_id: enterprise_helper.id, active: true) }

  let(:entity_permissions) do
    [
      FactoryBot.create(:entity_permission,
        role: role_coexistence_member,
        entity_type: AnswersPetition.name,
        can_read: true,
        can_write: true,
        can_destroy: true,
        can_change_status: true),
      FactoryBot.create(:entity_permission,
        role: role_council_member,
        entity_type: AnswersPetition.name,
        can_read: true,
        can_write: true,
        can_destroy: true,
        can_change_status: true)
    ]
  end

  let(:group_role) {
    group = FactoryBot.create(:group_role, :council_coexistence)

    FactoryBot.create(:group_role_relation, role: role_coexistence_member, group_role: group)
    FactoryBot.create(:group_role_relation, role: role_council_member, group_role: group)

    group
  }

  let(:petition) {
    return if @petition.present?

    user_enterprise_petition
    status_pending

    data = {
      title: "Test PQR",
      message: "message test 1",
      category_petition_id: category.id,
      group_role_id: group_role.id
    }

    @petition = ::Petitions::CreateService.new(user: user_2, data: data).call
  }

  let(:answer) {
    data = {
      message: "message test 1",
    }

    ::AnswersPetitions::CreateService.new(petition: petition, user: user_2, data: data).call
  }

  let(:answer2) {
    data = {
      message: "message test 1",
    }

    ::AnswersPetitions::CreateService.new(petition: petition, user: user, data: data).call
  }
end
