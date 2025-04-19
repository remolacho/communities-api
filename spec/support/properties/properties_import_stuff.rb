# frozen_string_literal: true

RSpec.shared_context 'properties_import_stuff' do
  include RequestHelpers

  let(:role_admin) { FactoryBot.create(:role, :role_admin) }
  let(:role_coexistence_member) { FactoryBot.create(:role, :coexistence_member) }

  let(:entity_permissions) {
    [
      FactoryBot.create(:entity_permission,
        role: role_admin,
        entity_type: Property.name,
        can_read: true,
        can_write: true,
        can_destroy: true,
        can_change_status: true
      ),
      FactoryBot.create(:entity_permission,
        role: role_coexistence_member,
        entity_type: Property.name,
        can_read: false,
        can_write: false,
        can_destroy: false,
        can_change_status: false
      )
    ]
  }

  let(:enterprise) { enterprise_helper }
  let(:user) { current_user }
  let(:user_enterprise) { user_enterprise_helper }

  let(:user_role_admin) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_admin.id) }
  let(:user_role_coexistence_member) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_coexistence_member.id) }

  # Property Statuses
  let(:status_own) { FactoryBot.create(:status, :property_own) }
  let(:status_rented) { FactoryBot.create(:status, :property_rented) }
  let(:status_loan) { FactoryBot.create(:status, :property_loan) }
  let(:status_empty) { FactoryBot.create(:status, :property_empty) }

  # Property Types
  let(:property_type_apartment) { FactoryBot.create(:property_type, :apartamento, enterprise: enterprise) }
  let(:property_type_commercial) { FactoryBot.create(:property_type, :local_comercial, enterprise: enterprise) }
  let(:property_type_parking) { FactoryBot.create(:property_type, :parqueadero, enterprise: enterprise) }
  let(:property_type_parking_visitor) { FactoryBot.create(:property_type, :parqueadero_visitante, enterprise: enterprise) }
  let(:property_type_storage) { FactoryBot.create(:property_type, :deposito, enterprise: enterprise) }
  let(:property_type_bicycle) { FactoryBot.create(:property_type, :bicicletero, enterprise: enterprise) }
  let(:property_type_parking_disabled) { FactoryBot.create(:property_type, :parqueadero_discapacitado, enterprise: enterprise) }

  # Test Files
  let(:success_file) do
    Rack::Test::UploadedFile.new(
      './spec/files/properties/success.xlsx',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
  end

  let(:error_without_status_file) do
    Rack::Test::UploadedFile.new(
      './spec/files/properties/error_without_status.xlsx',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
  end

  let(:location_error_file) do
    Rack::Test::UploadedFile.new(
      './spec/files/properties/location_error.xlsx',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
  end

  let(:type_location_blank_error_file) do
    Rack::Test::UploadedFile.new(
      './spec/files/properties/type_location_blank_error.xlsx',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
  end

  let(:type_error_file) do
    Rack::Test::UploadedFile.new(
      './spec/files/properties/type_error.xlsx',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
  end

  let(:status_error_file) do
    Rack::Test::UploadedFile.new(
      './spec/files/properties/status_error.xlsx',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
  end

  before do
    entity_permissions
    status_own
    status_rented
    status_loan
    status_empty
    property_type_apartment
    property_type_commercial
    property_type_parking
    property_type_parking_visitor
    property_type_storage
    property_type_bicycle
    property_type_parking_disabled
  end
end
