shared_context 'sign_up_stuff' do
  include RequestHelpers

  let(:enterprise) { enterprise_helper }
  let(:user) { current_user }
  let(:user_enterprise) { user_enterprise_helper }
  let!(:role_owner_admin) { FactoryBot.create(:role, :owner_admin) }

  let(:allowed_params) {
    {
      name: FFaker::Name.first_name,
      lastname: FFaker::Name.last_name,
      identifier: "#{FFaker::IdentificationESCL.rut}-#{20 + Random.rand(110)}",
      email: "#{FFaker::Name.first_name}.#{20 + Random.rand(11)}#{20 + Random.rand(11)}#{20 + Random.rand(11)}@community.com",
      address: "T4, P11, A1102",
      phone: "3174131149",
      password: 'test123',
      password_confirmation: 'test123'
    }
  }

  let(:allowed_params_2) {
    {
      name: FFaker::Name.first_name,
      lastname: FFaker::Name.last_name,
      identifier: "#{FFaker::IdentificationESCL.rut}-#{20 + Random.rand(110)}",
      email: "#{FFaker::Name.first_name}.#{20 + Random.rand(11)}#{20 + Random.rand(11)}#{20 + Random.rand(11)}@community.com",
      address: "T4, P11, A1102",
      phone: "3174131149",
      password: 'test123',
      password_confirmation: 'test123'
    }
  }

  let(:allowed_params_3) {
    {
      name: FFaker::Name.first_name,
      lastname: FFaker::Name.last_name,
      identifier: "#{FFaker::IdentificationESCL.rut}-#{20 + Random.rand(110)}",
      email: "#{FFaker::Name.first_name}.#{20 + Random.rand(11)}#{20 + Random.rand(11)}#{20 + Random.rand(11)}@community.com",
      address: "T4, P11, A1102",
      phone: "3174131149",
      password: 'test123',
      password_confirmation: 'test123'
    }
  }
end
