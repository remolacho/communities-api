# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Properties::UpdateService do
  include_context 'property_stuff'

  let(:property) do
    FactoryBot.create(:property,
           enterprise: enterprise,
           property_type: apartment_type,
           location: valid_apartment_locations.first,
           status: status)
  end

  let(:valid_params) do
    {
      property_type_id: apartment_type.id,
      location: valid_apartment_locations.last,
      status_id: status.id
    }
  end

  let(:service) { described_class.new(property, valid_params, user) }

  describe '#call' do
    context 'when all parameters are valid' do
      it 'updates the property' do
        expect { service.call }.to change { property.reload.location }
          .from(valid_apartment_locations.first)
          .to(valid_apartment_locations.last)
      end
    end

    context 'when property type does not exist' do
      let(:invalid_params) { valid_params.merge(property_type_id: 999) }
      let(:service) { described_class.new(property, invalid_params, user) }

      it 'raises RecordNotFound error' do
        expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when status does not exist' do
      let(:invalid_params) { valid_params.merge(status_id: 999) }
      let(:service) { described_class.new(property, invalid_params, user) }

      it 'raises RecordNotFound error' do
        expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when updating only one attribute' do
      let(:partial_params) { { status_id: status.id } }
      let(:service) { described_class.new(property, partial_params, user) }

      it 'updates only the specified attribute' do
        expect { service.call }.not_to change { property.reload.location }
        expect { service.call }.not_to change { property.reload.property_type_id }
      end
    end
  end
end
