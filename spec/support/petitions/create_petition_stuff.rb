# frozen_string_literal: true

shared_context 'create_petition_stuff' do
  include RequestHelpers

  let!(:status_pending) { @status_pending ||= FactoryBot.create(:status, :petition_pending) }
  let!(:user_enterprise) { user_enterprise_helper }

  let(:enterprise) { enterprise_helper }
  let(:user) { current_user }
  let(:category) { @category ||= FactoryBot.create(:category_petition, :petition , enterprise: enterprise_helper) }

  let(:group_role) {
    role_coexistence_member = FactoryBot.create(:role, :coexistence_member)
    role_council_member = FactoryBot.create(:role, :council_member)

    group = FactoryBot.create(:group_role, :council_coexistence)

    FactoryBot.create(:group_role_relation, role: role_coexistence_member, group_role: group)
    FactoryBot.create(:group_role_relation, role: role_council_member, group_role: group)

    group
  }
end
