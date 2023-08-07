# frozen_string_literal: true

shared_context 'create_petition_stuff' do
  include RequestHelpers

  let!(:status_pending) { @status_pending ||= FactoryBot.create(:status, :petition_pending) }
  let!(:user_enterprise) { user_enterprise_helper }

  let(:enterprise) { enterprise_helper }
  let(:user) { current_user }
  let(:category) { @category ||= FactoryBot.create(:category_petition, :petition , enterprise: enterprise_helper) }

  let(:group_role) {
    role1 = FactoryBot.create(:role, :coexistence_member)
    role2 = FactoryBot.create(:role, :committee_member)
    group = FactoryBot.create(:group_role, :coexistence_committee)

    FactoryBot.create(:group_role_relation, role: role1, group_role: group)
    FactoryBot.create(:group_role_relation, role: role2, group_role: group)

    group
  }
end
