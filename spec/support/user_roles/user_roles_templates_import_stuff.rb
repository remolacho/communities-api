# frozen_string_literal: true

shared_context 'user_roles_templates_import_stuff' do
  include RequestHelpers

  let(:user) { current_user }
  let(:enterprise) { enterprise_helper }
  let!(:user_enterprise) { user_enterprise_helper }

  let!(:role_coexistence_member){ FactoryBot.create(:role, :coexistence_member) }
  let!(:role_council_member){ FactoryBot.create(:role, :council_member) }
  let!(:role_owner_admin){ FactoryBot.create(:role, :owner_admin) }
  let!(:role_admin){ FactoryBot.create(:role, :role_admin) }

  let(:user_role_admin) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_admin.id) }

  let(:sign_up) {
    allowed_params = {
      name: FFaker::Name.first_name,
      lastname: FFaker::Name.last_name,
      identifier: "12345678",
      email: "#{FFaker::Name.first_name}.#{20 + Random.rand(11)}#{20 + Random.rand(11)}#{20 + Random.rand(11)}@community.com",
      reference: "T4-P11-A1102",
      phone: "3174131149",
      password: 'test123',
      password_confirmation: 'test123'
    }

    ::Users::SignUpService.new(enterprise: enterprise, data: allowed_params).call
  }

  let(:new_user_admin){
    u = sign_up
    FactoryBot.create(:user_role, user_id: u.id, role_id: role_admin.id)
    u
  }
end
