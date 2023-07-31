shared_context 'list_group_roles_petitions_stuff' do
  include RequestHelpers

  let(:status_pending) { @status_pending ||= FactoryBot.create(:status, :petition_pending) }
  let(:status_resolved) { @status_resolved ||= FactoryBot.create(:status, :petition_resolved) }

  let(:category_petition) { @category_petition ||= FactoryBot.create(:category_petition, :petition , enterprise: enterprise_helper) }
  let(:category_complaint) { @category_complaint ||= FactoryBot.create(:category_petition, :complaint , enterprise: enterprise_helper) }

  let(:role1){ FactoryBot.create(:role, :coexistence_member) }
  let(:role2){ FactoryBot.create(:role, :committee_member) }
  let(:role3){ FactoryBot.create(:role, :owner_admin) }
  let(:role4){ FactoryBot.create(:role, :role_admin) }

  let(:group_role_coexistence_committee) {
    group = FactoryBot.create(:group_role, :coexistence_committee)

    FactoryBot.create(:group_role_relation, role: role1, group_role: group)
    FactoryBot.create(:group_role_relation, role: role2, group_role: group)

    group
  }

  let(:group_role_admin) {
    group = FactoryBot.create(:group_role, :admin)

    FactoryBot.create(:group_role_relation, role: role4, group_role: group)

    group
  }

  let(:enterprise) { enterprise_helper }
  let(:user) { current_user }
  let(:user_enterprise) { user_enterprise_helper }
  let(:user_role_coexistence_member) { FactoryBot.create(:user_role, user_id: user.id, role_id: role1.id) }
  let(:user_role_committee_member) { FactoryBot.create(:user_role, user_id: user.id, role_id: role2.id) }
  let(:user_role_owner_admin) { FactoryBot.create(:user_role, user_id: user.id, role_id: role3.id) }
  let(:user_role_admin) { FactoryBot.create(:user_role, user_id: user.id, role_id: role4.id) }

  let(:user_2) { FactoryBot.create(:user) }
  let(:user_enterprise_2) {  FactoryBot.create(:user_enterprise, user_id: user_2.id, enterprise_id: enterprise_helper.id, active: true) }
  let(:user_2_role_owner_admin) { FactoryBot.create(:user_role, user_id: user_2.id, role_id: role3.id) }
end
