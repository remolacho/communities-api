# frozen_string_literal: true

shared_context 'user_roles_templates_import_stuff' do
  include RequestHelpers

  let(:user) { current_user }
  let(:enterprise) { enterprise_helper }
  let!(:user_enterprise) { user_enterprise_helper }

  let!(:role1){ FactoryBot.create(:role, :coexistence_member) }
  let!(:role2){ FactoryBot.create(:role, :committee_member) }
  let!(:role3){ FactoryBot.create(:role, :owner_admin) }
  let!(:role4){ FactoryBot.create(:role, :role_admin) }

  let(:user_role_admin) { FactoryBot.create(:user_role, user_id: user.id, role_id: role4.id) }
end
