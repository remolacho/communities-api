# frozen_string_literal: true

shared_context 'group_roles_stuff' do
  include RequestHelpers

  let(:user) { current_user }
  let(:enterprise) { enterprise_helper }
  let(:user_enterprise) { user_enterprise_helper }

  let!(:group_roles) {
    [
      FactoryBot.create(:group_role, :all),
      FactoryBot.create(:group_role, :admin_committee),
      FactoryBot.create(:group_role, :coexistence_committee)
    ]
  }
end
