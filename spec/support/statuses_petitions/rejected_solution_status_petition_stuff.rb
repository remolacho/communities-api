shared_context 'rejected_solution_status_petition_stuff' do
  include RequestHelpers

  let!(:status_pending) { @status_pending ||= FactoryBot.create(:status, :petition_pending) }
  let!(:status_rejected) { @status_rejected ||= FactoryBot.create(:status, :petition_rejected) }
  let!(:status_reviewing) { @status_reviewing ||= FactoryBot.create(:status, :petition_reviewing) }
  let!(:status_confirm) { @status_confirm ||= FactoryBot.create(:status, :petition_confirm) }
  let!(:status_resolved) { @status_resolved ||= FactoryBot.create(:status, :petition_resolved) }
  let!(:status_rejected_solution) { @status_rejected_solution ||= FactoryBot.create(:status, :petition_rejected_solution) }

  let(:category) { @category ||= FactoryBot.create(:category_petition, :petition , enterprise: enterprise_helper) }

  let(:role_coexistence_member){ FactoryBot.create(:role, :coexistence_member) }
  let(:role_council_member){ FactoryBot.create(:role, :council_member) }

  let(:group_role) {
    group = FactoryBot.create(:group_role, :council_coexistence)

    FactoryBot.create(:group_role_relation, role: role_coexistence_member, group_role: group)
    FactoryBot.create(:group_role_relation, role: role_council_member, group_role: group)

    group
  }

  let(:user) { current_user }
  let(:user_enterprise) { user_enterprise_helper }
  let(:user_role){ FactoryBot.create(:user_role, user_id: user.id, role_id: role_council_member.id) }

  let(:user_2) { @user_2 ||= FactoryBot.create(:user) }
  let(:user_enterprise_2) {  FactoryBot.create(:user_enterprise, user_id: user_2.id, enterprise_id: enterprise_helper.id, active: true) }

  let(:petition) {
    user_enterprise_2
    status_pending

    data = {
      title: "Test PQR",
      message: "message test 1",
      category_petition_id: category.id,
      group_role_id: group_role.id
    }

    current_petition = ::Petitions::CreateService.new(user: user_2, data: data).call
    current_petition.status_id = status_rejected_solution.id
    current_petition.save!
    current_petition.reload
  }
end
