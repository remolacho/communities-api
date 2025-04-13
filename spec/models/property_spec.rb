# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Property, type: :model do
  include_context 'property_stuff'

  describe 'location validations' do
    context 'when property type is Apartamento' do
      let(:property_type) { apartment_type }

      it 'validates valid locations' do
        valid_apartment_locations.each do |location|
          property = FactoryBot.build(:property,
            location: location,
            property_type: property_type,
            enterprise: enterprise,
            status: status)

          expect(property).to be_valid
          expect(property.errors[:location]).to be_empty
        end
      end

      it 'invalidates incorrect locations' do
        invalid_apartment_locations.each do |location|
          property = FactoryBot.build(:property,
            location: location,
            property_type: property_type,
            enterprise: enterprise,
            status: status)

          expect(property).not_to be_valid
          expect(property.errors[:location]).to include(I18n.t('errors.messages.invalid_format'))
        end
      end
    end

    context 'when property type is Local Comercial' do
      let(:property_type) { commercial_type }

      it 'validates valid locations' do
        valid_commercial_locations.each do |location|
          property = FactoryBot.build(:property,
            location: location,
            property_type: property_type,
            enterprise: enterprise,
            status: status)

          expect(property).to be_valid
          expect(property.errors[:location]).to be_empty
        end
      end

      it 'invalidates incorrect locations' do
        invalid_commercial_locations.each do |location|
          property = FactoryBot.build(:property,
            location: location,
            property_type: property_type,
            enterprise: enterprise,
            status: status)

          expect(property).not_to be_valid
          expect(property.errors[:location]).to include(I18n.t('errors.messages.invalid_format'))
        end
      end
    end

    context 'when property type is Parqueadero' do
      let(:property_type) { parking_type }

      it 'validates valid locations' do
        valid_parking_locations.each do |location|
          property = FactoryBot.build(:property,
            location: location,
            property_type: property_type,
            enterprise: enterprise,
            status: status)

          expect(property).to be_valid
          expect(property.errors[:location]).to be_empty
        end
      end

      it 'invalidates incorrect locations' do
        invalid_parking_locations.each do |location|
          property = FactoryBot.build(:property,
            location: location,
            property_type: property_type,
            enterprise: enterprise,
            status: status)

          expect(property).not_to be_valid
          expect(property.errors[:location]).to include(I18n.t('errors.messages.invalid_format'))
        end
      end
    end

    context 'when property type is Depósito' do
      let(:property_type) { storage_type }

      it 'validates valid locations' do
        valid_storage_locations.each do |location|
          property = FactoryBot.build(:property,
            location: location,
            property_type: property_type,
            enterprise: enterprise,
            status: status)

          expect(property).to be_valid
          expect(property.errors[:location]).to be_empty
        end
      end

      it 'invalidates incorrect locations' do
        invalid_storage_locations.each do |location|
          property = FactoryBot.build(:property,
            location: location,
            property_type: property_type,
            enterprise: enterprise,
            status: status)

          expect(property).not_to be_valid
          expect(property.errors[:location]).to include(I18n.t('errors.messages.invalid_format'))
        end
      end
    end

    context 'when property type is Bicicletero' do
      let(:property_type) { bicycle_type }

      it 'validates valid locations' do
        valid_bicycle_locations.each do |location|
          property = FactoryBot.build(:property,
            location: location,
            property_type: property_type,
            enterprise: enterprise,
            status: status)

          expect(property).to be_valid
          expect(property.errors[:location]).to be_empty
        end
      end

      it 'invalidates incorrect locations' do
        invalid_bicycle_locations.each do |location|
          property = FactoryBot.build(:property,
            location: location,
            property_type: property_type,
            enterprise: enterprise,
            status: status)

          expect(property).not_to be_valid
          expect(property.errors[:location]).to include(I18n.t('errors.messages.invalid_format'))
        end
      end
    end

    context 'when property type is Parqueadero discapacitado' do
      let(:property_type) { parking_disabled_type }

      it 'validates valid locations' do
        valid_parking_disabled_locations.each do |location|
          property = FactoryBot.build(:property,
            location: location,
            property_type: property_type,
            enterprise: enterprise,
            status: status)

          expect(property).to be_valid
          expect(property.errors[:location]).to be_empty
        end
      end

      it 'invalidates incorrect locations' do
        invalid_parking_disabled_locations.each do |location|
          property = FactoryBot.build(:property,
            location: location,
            property_type: property_type,
            enterprise: enterprise,
            status: status)

          expect(property).not_to be_valid
          expect(property.errors[:location]).to include(I18n.t('errors.messages.invalid_format'))
        end
      end
    end

    context 'when property_type or location is blank' do
      let(:property_type) { apartment_type }

      it 'skips validation when property_type is nil' do
        property = FactoryBot.build(:property,
          location: "T0-P1-A101",
          property_type: nil,
          enterprise: enterprise,
          status: status)

        expect(property).not_to be_valid
        expect(property.errors[:property_type]).to include(I18n.t('errors.messages.required'))
        expect(property.errors[:location]).not_to include(I18n.t('errors.messages.invalid_format'))
      end

      it 'skips validation when location is blank' do
        property = FactoryBot.build(:property,
          location: "",
          property_type: property_type,
          enterprise: enterprise,
          status: status)

        expect(property).not_to be_valid
        expect(property.errors[:location]).to include(I18n.t('errors.messages.blank'))
        expect(property.errors[:location]).not_to include(I18n.t('errors.messages.invalid_format'))
      end
    end
  end
end
