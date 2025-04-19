# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Properties::Template::StructureService do
  include_context 'properties_import_stuff'

  let(:service) { described_class.new(user: user) }
  let(:result) { service.call }

  describe '#call' do
    before do
      user_role_admin
    end

    it 'returns both sheets structure' do
      expect(result.keys).to match_array([:import_sheet, :types_sheet])
    end

    describe 'import_sheet' do
      let(:headers) { result[:import_sheet] }

      it 'includes all property statuses with their codes' do
        expected_statuses = [
          "#{status_own.name[I18n.locale.to_s]}##{status_own.code}",
          "#{status_rented.name[I18n.locale.to_s]}##{status_rented.code}",
          "#{status_loan.name[I18n.locale.to_s]}##{status_loan.code}",
          "#{status_empty.name[I18n.locale.to_s]}##{status_empty.code}"
        ]

        expect(headers).to include(*expected_statuses)
      end
    end

    describe 'types_sheet' do
      let(:types_data) { result[:types_sheet] }

      it 'has correct headers' do
        expect(types_data.first).to eq(['Tipo de propiedad', 'Localización (Nomenclatura)'])
      end

      it 'includes all property types with their placeholders' do
        expected_types = [
          [property_type_apartment.name, property_type_apartment.placeholder],
          [property_type_commercial.name, property_type_commercial.placeholder],
          [property_type_parking.name, property_type_parking.placeholder],
          [property_type_storage.name, property_type_storage.placeholder],
          [property_type_bicycle.name, property_type_bicycle.placeholder],
          [property_type_parking_visitor.name, property_type_parking_visitor.placeholder],
          [property_type_parking_disabled.name, property_type_parking_disabled.placeholder]
        ]

        # Skip header row for comparison
        actual_types = types_data[1..]
        expect(actual_types).to match_array(expected_types)
      end

      it 'has correct number of rows (header + all property types)' do
        expect(types_data.size).to eq(8) # 1 header row + 7 property types
      end
    end
  end
end
