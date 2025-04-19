# frozen_string_literal: true

RSpec.shared_context 'property_list_stuff' do
  include_context 'property_stuff'

  let!(:properties_list) do
    [
      FactoryBot.create(:property,
             enterprise: enterprise,
             property_type: apartment_type,
             location: valid_apartment_locations[0],
             status: status),
      FactoryBot.create(:property,
             enterprise: enterprise,
             property_type: commercial_type,
             location: valid_commercial_locations[0],
             status: status),
      FactoryBot.create(:property,
             enterprise: enterprise,
             property_type: parking_type,
             location: valid_parking_locations[0],
             status: status),
      FactoryBot.create(:property,
             enterprise: enterprise,
             property_type: storage_type,
             location: valid_storage_locations[0],
             status: status),
      FactoryBot.create(:property,
             enterprise: enterprise,
             property_type: bicycle_type,
             location: valid_bicycle_locations[0],
             status: status)
    ]
  end
end
