# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Fines::Categories::CreateService do
  include_context 'create_category_stuff'

  let(:service) { described_class.new(user: user, **attributes) }

  describe '#call' do
    context 'with valid attributes' do
      let(:attributes) { valid_attributes }

      it 'creates a new category' do
        expect { service.call }.to change(CategoryFine, :count).by(1)
      end

      it 'sets the correct attributes' do
        category = service.call

        expect(category).to have_attributes(
          name: attributes[:name],
          code: attributes[:code],
          description: attributes[:description],
          formula: attributes[:formula],
          value: attributes[:value],
          active: attributes[:active],
          created_by: user,
          enterprise: enterprise
        )
      end
    end

    context 'with valid attributes and parent category' do
      let(:attributes) { valid_attributes_with_parent }

      it 'creates a new category with parent' do
        category = service.call

        expect(category.parent_category_fine).to eq(parent_category)
      end
    end

    context 'with invalid attributes' do
      let(:attributes) { invalid_attributes }

      it 'raises an error' do
        expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'with duplicate code' do
      let(:attributes) { duplicate_code_attributes }

      it 'raises a uniqueness error' do
        expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
