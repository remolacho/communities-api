# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Properties::Import::CreateService do
  include_context 'properties_import_stuff'

  describe '#call' do
    context 'when validating statuses' do
      it 'raises error when status code is not found' do
        service = described_class.new(user: user, file: status_error_file)

        expect { service.call }.to raise_error(
          ActiveRecord::RecordNotFound
        )
      end
    end

    context 'when validating property type' do
      it 'raises error when property type is not found' do
        service = described_class.new(user: user, file: type_error_file)

        expect { service.call }.to raise_error(
          ActiveRecord::RecordNotFound,
        )
      end
    end

    context 'when validating location' do
      it 'raises error when location format is invalid' do
        service = described_class.new(user: user, file: location_error_file)

        expect { service.call }.to raise_error(
          ActiveRecord::RecordNotFound,
        )
      end
    end

    context 'when property type and location are blank' do
      it 'raises error for missing data' do
        service = described_class.new(user: user, file: type_location_blank_error_file)

        expect { service.call }.to raise_error(
          ActiveRecord::RecordNotFound,
        )
      end
    end

    context 'when no status is marked' do
      it 'raises error for missing status' do
        service = described_class.new(user: user, file: error_without_status_file)

        expect { service.call }.to raise_error(
          ActiveRecord::RecordNotFound
        )
      end
    end

    context 'when file is valid' do
      it 'creates or updates properties and validate duplicates' do
        expect {
          service = described_class.new(user: user, file: success_file)
          service.call
        }.to change(Property, :count)

        expect {
          service = described_class.new(user: user, file: success_file)
          service.call
        }.not_to change(Property, :count)


        locations = ['T1-P1-A101', 'TE-L1', 'TE-P1-E1', 'TE-P1-D1', 'TE-P1-E1', 'TE-P1-B1']

        properties = enterprise.properties
        expect(properties.count).to eq(6)
        expect(properties.pluck(:location)).to match_array(locations)
      end
    end
  end
end
