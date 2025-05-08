# frozen_string_literal: true

RSpec.shared_context 'user_properties_stuff' do
  include RequestHelpers

  let(:enterprise) { enterprise_helper }
  let(:user) { current_user }
  let(:user_enterprise) { user_enterprise_helper }

  let(:role_admin) { FactoryBot.create(:role, :role_admin) }
  let(:user_role_admin) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_admin.id) }

  let(:apartment_type) { FactoryBot.create(:property_type, :apartamento, enterprise: enterprise) }
  let(:status) { FactoryBot.create(:status, :property_rented) }
  let(:user_one) { FactoryBot.create(:user, identifier: '123456', enterprise: enterprise) }
  let(:property_one) do
    FactoryBot.create(:property,
                      location: 'T1-P1-A1101',
                      enterprise: enterprise,
                      property_type: apartment_type,
                      status: status)
  end

  let!(:property_owner_type_default) { FactoryBot.create(:property_owner_type, :propietario, enterprise: enterprise) }

  let(:valid_data) do
    [
      {
        'identificador' => user_one.identifier,
        'localizacion' => property_one.location
      }
    ]
  end

  let(:invalid_user_data) do
    [
      {
        'identificador' => 'non_existent_user',
        'localizacion' => property_one.location
      }
    ]
  end

  let(:invalid_property_data) do
    [
      {
        'identificador' => user_one.identifier,
        'localizacion' => 'T5-P1-A101'
      }
    ]
  end
end
