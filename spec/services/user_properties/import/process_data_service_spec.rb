# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserProperties::Import::ProcessDataService do
  include_context 'user_properties_stuff'

  let(:service) { described_class.new(user: user) }

  describe '#call' do
    context 'when data is valid' do
      it 'creates user_property successfully' do
        expect { service.call(valid_data) }.to change(UserProperty, :count).by(1)

        user_property = UserProperty.last
        expect(user_property.user).to eq(user_one)
        expect(user_property.property).to eq(property_one)
        expect(user_property.property_owner_type).to eq(property_owner_type_default)
        expect(user_property.active).to be true
      end
    end

    context 'when user does not exist' do
      it 'raises RecordNotFound error' do
        expect { service.call(invalid_user_data) }.to raise_error(
          ActiveRecord::RecordNotFound
        )
      end
    end

    context 'when property does not exist' do
      it 'raises RecordNotFound error' do
        expect { service.call(invalid_property_data) }.to raise_error(
          ActiveRecord::RecordNotFound
        )
      end
    end
  end
end
