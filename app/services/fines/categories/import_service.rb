# frozen_string_literal: true

module Fines
  module Categories
    class ImportService
      attr_reader :user, :file, :enterprise

      def initialize(user:, file:)
        @user = user
        @file = file
        @enterprise = user.enterprise
      end

      def call
        raise ArgumentError, I18n.t('services.fines.categories.no_file') if file.blank?
        raise ArgumentError, I18n.t('services.fines.categories.file_not_readable') if xlsx.nil?

        valid_header!
        validate_has_data!
        process_excel
      end

      private

      def validate_has_data!
        raise ArgumentError, I18n.t('services.fines.categories.no_data') if xlsx.last_row <= 1
      end

      def process_excel
        categories_data = []
        parent_relations = {}

        (2..xlsx.last_row).each do |i|
          row = header.zip(xlsx.row(i)).to_h
          next unless valid_row?(row)

          parent_relations[row['code']] = row['parent_code'] if row['parent_code'].present?

          categories_data << build_category_data(row)
        end

        return if categories_data.blank?

        upsert_all(categories_data)
        update_parent_relations(parent_relations)
      end

      def build_category_data(row)
        {
          code: row['code'].to_s,
          name: row['name'].to_s,
          description: row['description'],
          formula: row['formula'],
          value: row['value'].to_f,
          active: true,
          parent_category_fine_id: nil,
          enterprise_id: enterprise.id,
          created_by_id: user.id,
          created_at: Time.current,
          updated_at: Time.current
        }
      end

      def upsert_all(categories_data)
        CategoryFine.upsert_all(
          categories_data,
          unique_by: [:enterprise_id, :code],
          returning: false
        )
      end

      def update_parent_relations(parent_relations)
        parent_relations.each do |child_code, parent_code|
          child = enterprise.category_fines.find_by(code: child_code)
          parent = enterprise.category_fines.find_by(code: parent_code)

          child.update_column(:parent_category_fine_id, parent.id) if child && parent
        end
      end

      def header
        @header ||= xlsx.first
      end

      def xlsx
        @xlsx ||= read_xlsx
      end

      def valid_header!
        allowed = ['code', 'parent_code', 'name', 'description', 'formula', 'value']

        return if allowed.all? { |h| h.in?(header) }

        raise ArgumentError, I18n.t('services.fines.categories.invalid_header')
      end

      def valid_row?(row)
        row['code'].present? && row['name'].present? && row['value'].present?
      end

      def read_xlsx
        @read_xlsx ||= begin
          (Roo::Spreadsheet.open file.tempfile.path, extension: 'xlsx')
        rescue StandardError
          nil
        end
      end
    end
  end
end
