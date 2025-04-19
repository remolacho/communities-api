# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Properties::CreateService do
  include_context 'property_stuff'

  let(:valid_params) do
    {
      property_type_id: apartment_type.id,
      location: valid_apartment_locations.first,
      status_id: status.id
    }
  end

  describe '#call' do
    context 'when params are valid' do
      it 'creates a new property' do
        service = described_class.new(user: user, params: valid_params)

        expect { service.call }.to change(Property, :count).by(1)

        property = Property.last
        expect(property.property_type_id).to eq valid_params[:property_type_id]
        expect(property.location).to eq valid_params[:location]
        expect(property.status_id).to eq valid_params[:status_id]
        expect(property.enterprise_id).to eq enterprise.id
      end
    end

    context 'when property type is invalid' do
      it 'raises RecordNotFound error' do
        params = valid_params.merge(property_type_id: 999)
        service = described_class.new(user: user, params: params)

        expect { service.call }.to raise_error(
          ActiveRecord::RecordNotFound
        )
      end
    end

    context 'when location format is invalid' do
      it 'raises RecordInvalid error' do
        params = valid_params.merge(location: invalid_apartment_locations.first)
        service = described_class.new(user: user, params: params)

        expect { service.call }.to raise_error(
          ActiveRecord::RecordInvalid
        )
      end
    end
  end
end
