# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Fines::Categories::ImportService do
  include_context 'import_categories_stuff'

  describe '#call' do
    context 'when user has admin role' do
      before { user_role_admin }

      context 'when file has errors' do
        it 'file is not provided raises an error' do
          service = described_class.new(user: user, file: nil)
          expect { service.call }.to raise_error(
            ArgumentError,
            I18n.t('services.fines.categories.no_file')
          )
        end

        it 'invalid header raises an error' do
          service = described_class.new(user: user, file: error_header_file)
          expect { service.call }.to raise_error(
            ArgumentError,
            I18n.t('services.fines.categories.invalid_header')
          )
        end

        it 'raises existing categories duplicates' do
          service = described_class.new(user: user, file: duplicated_code_file)
          expect { service.call }.to raise_error(
            ActiveRecord::StatementInvalid
          )
        end

        it 'file only contains headers raises an error' do
          service = described_class.new(user: user, file: only_headers_file)
          expect { service.call }.to raise_error(
            ArgumentError,
            I18n.t('services.fines.categories.no_data')
          )
        end
      end

      context 'when file has valid data' do
        it 'creates categories successfully' do
          service = described_class.new(user: user, file: success_file)
          expect { service.call }.to change(CategoryFine, :count).by(9)
        end

        it 'sets correct attributes' do
          service = described_class.new(user: user, file: success_file)
          service.call

          category = CategoryFine.last
          expect(category.enterprise).to eq(enterprise)
          expect(category.created_by).to eq(user)
          expect(category.active).to be true
        end
      end

      context 'when file has empty codes' do
        it 'skips invalid rows' do
          service = described_class.new(user: user, file: code_empty_file)
          expect { service.call }.to change(CategoryFine, :count).by(9) # 10 rows - 1 empty
        end
      end

      context 'when file has parent-child relationships' do
        it 'creates categories with correct relationships' do
          service = described_class.new(user: user, file: all_childs_file)
          service.call

          parent = CategoryFine.find_by(code: 'CAT001', parent_category_fine_id: nil)
          children = parent.child_category_fines

          expect(parent.present?).to be true
          expect(children.count).to eq(9)
        end
      end
    end
  end
end
