# frozen_string_literal: true

RSpec.shared_context 'property_stuff' do
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

  let(:enterprise) { enterprise_helper }
  let(:status) { FactoryBot.create(:status, :property_rented) }

  # Valid locations for each property type
  let(:valid_apartment_locations) { ['T1-P1-A1101', 'T4-P16-A108', 'T2-P9-A908'] }
  let(:valid_commercial_locations) { ['TE-L1', 'TE-L42', 'TE-L999', 'TE-L1000'] }
  let(:valid_parking_locations) { ['TE-P1-E1', 'TE-P10-E99', 'TE-P5-E100'] }
  let(:valid_storage_locations) { ['TE-P1-D1', 'TE-P10-D99', 'TE-P5-D100'] }
  let(:valid_bicycle_locations) { ['TE-P1-B1', 'TE-P10-B99', 'TE-P5-B100'] }
  let(:valid_parking_disabled_locations) { ['TE-P1-E7', 'TE-P10-E99', 'TE-P5-E100'] }

  # Invalid locations for each property type
  let(:invalid_apartment_locations) do
    [
      'T5-P1-A101',    # Torre inválida (T5)
      'T4-P17-A101',   # Piso inválido (P17)
      'T4-P1-A1609',   # Apartamento inválido (A1609)
      'invalid',       # Formato totalmente inválido
      'T1P1A101'      # Sin guiones
    ]
  end

  let(:invalid_commercial_locations) do
    [
      'TE-L0',      # Número inválido (0)
      'TE-L1001',   # Número fuera de rango (1001)
      'TE-LA',      # Letra en lugar de número
      'TEL1',       # Sin guión
      'invalid'     # Formato totalmente inválido
    ]
  end

  let(:invalid_parking_locations) do
    [
      'TE-P0-E1',    # Piso inválido (P0)
      'TE-P11-E1',   # Piso fuera de rango (P11)
      'TE-P1-E101',  # Espacio fuera de rango (E101)
      'TE-P1E1',     # Sin guión
      'invalid'      # Formato totalmente inválido
    ]
  end

  let(:invalid_storage_locations) do
    [
      'TE-P0-D1',    # Piso inválido (P0)
      'TE-P11-D1',   # Piso fuera de rango (P11)
      'TE-P1-D101',  # Depósito fuera de rango (D101)
      'TE-P1D1',     # Sin guión
      'invalid'      # Formato totalmente inválido
    ]
  end

  let(:invalid_bicycle_locations) do
    [
      'TE-P0-B1',    # Piso inválido (P0)
      'TE-P11-B1',   # Piso fuera de rango (P11)
      'TE-P1-B101',  # Bicicletero fuera de rango (B101)
      'TE-P1B1',     # Sin guión
      'invalid'      # Formato totalmente inválido
    ]
  end

  let(:invalid_parking_disabled_locations) do
    [
      'TE-P0-PD1',    # Piso inválido (P0)
      'TE-P11-PD1',   # Piso fuera de rango (P11)
      'TE-P1-PD101',  # Parqueadero discapacitado fuera de rango (PD101)
      'TE-P1PD1',     # Sin guión
      'invalid'       # Formato totalmente inválido
    ]
  end

  # Property types
  let(:apartment_type) { FactoryBot.create(:property_type, :apartamento, enterprise: enterprise) }
  let(:commercial_type) { FactoryBot.create(:property_type, :local_comercial, enterprise: enterprise) }
  let(:parking_type) { FactoryBot.create(:property_type, :parqueadero, enterprise: enterprise) }
  let(:storage_type) { FactoryBot.create(:property_type, :deposito, enterprise: enterprise) }
  let(:bicycle_type) { FactoryBot.create(:property_type, :bicicletero, enterprise: enterprise) }
  let(:parking_disabled_type) { FactoryBot.create(:property_type, :parqueadero_discapacitado, enterprise: enterprise) }
end
