# frozen_string_literal: true

RSpec.shared_context 'user_properties_remove_stuff' do
  include RequestHelpers

  let(:enterprise) { enterprise_helper }
  let(:user) { current_user }
  let(:user_enterprise) { user_enterprise_helper }

  let(:role_admin) { FactoryBot.create(:role, :role_admin) }
  let(:user_role_admin) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_admin.id) }

  # Entity permissions for admin role
  let!(:entity_permissions) do
    FactoryBot.create(:entity_permission,
      role: role_admin,
      entity_type: UserProperty.name,
      can_read: true,
      can_write: true,
      can_destroy: true,
      can_change_status: true
    )
  end

  let(:apartment_type) { FactoryBot.create(:property_type, :apartamento, enterprise: enterprise) }
  let(:status) { FactoryBot.create(:status, :property_rented) }

  # Users to be removed
  let(:user_one) { FactoryBot.create(:user, identifier: '12345678', enterprise: enterprise) }
  let(:user_two) { FactoryBot.create(:user, identifier: '123456789', enterprise: enterprise) }

  # Properties
  let(:property_one) do
    FactoryBot.create(:property,
                      location: 'T1-P1-A101',
                      enterprise: enterprise,
                      property_type: apartment_type,
                      status: status)
  end

  let(:property_two) do
    FactoryBot.create(:property,
                      location: 'T1-P1-A102',
                      enterprise: enterprise,
                      property_type: apartment_type,
                      status: status)
  end

  let!(:property_owner_type_default) { FactoryBot.create(:property_owner_type, :propietario, enterprise: enterprise) }

  # Create UserProperties
  let!(:user_property_one) do
    FactoryBot.create(:user_property,
                      user: user_one,
                      property: property_one,
                      property_owner_type: property_owner_type_default,
                      active: true)
  end

  let!(:user_property_two) do
    FactoryBot.create(:user_property,
                      user: user_two,
                      property: property_two,
                      property_owner_type: property_owner_type_default,
                      active: true)
  end

  # Test files
  let(:template_success) do
    Rack::Test::UploadedFile.new(
      'spec/files/user_properties/remove/template_success.xlsx',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
  end

  let(:template_header_error) do
    Rack::Test::UploadedFile.new(
      'spec/files/user_properties/remove/template_header_error.xlsx',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
  end

  let(:template_user_error) do
    Rack::Test::UploadedFile.new(
      'spec/files/user_properties/remove/template_user_error.xlsx',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
  end
end
