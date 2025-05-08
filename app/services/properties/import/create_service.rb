# frozen_string_literal: true

module Properties
  module Import
    class CreateService
      attr_reader :file, :enterprise, :user

      def initialize(user:, file:)
        @user = user
        @enterprise = user.enterprise
        @file = file
      end

      def call
        if read_rows.blank?
          raise ActiveRecord::RecordNotFound,
                I18n.t('services.properties.import.read_xlsx.errors.file_blank')
        end

        enterprise.properties.upsert_all(
          read_rows,
          unique_by: [:property_type_id, :location],
          update_only: [:status_id]
        )
      end

      private

      def read_rows
        @read_rows ||= (2..workbook.sheet(0).last_row).map do |i|
          row = header.zip(workbook.row(i)).to_h

          valid_row_types!(row, i)
          valid_row_status!(row, i)

          process_row(row)
        end
      end

      def process_row(row)
        status_code = status_keys.find { |key| row[key]&.upcase == 'X' }
        status = statuses[status_code.split('#')[1]]
        pt = property_types[row['tipo-propiedad']]

        {
          status_id: status.id,
          property_type_id: pt.id,
          location: row['localizacion'],
          active: true,
          created_at: Time.current,
          updated_at: Time.current
        }
      end

      def valid_row_status!(row, index)
        status_code = status_keys.find { |key| row[key]&.upcase == 'X' }

        if status_code.nil?
          raise ActiveRecord::RecordNotFound,
                I18n.t('services.properties.import.read_xlsx.errors.status_blank', index: index)
        end

        status = statuses[status_code.split('#')[1]]

        return unless status.nil?

        raise ActiveRecord::RecordNotFound,
              I18n.t('services.properties.import.read_xlsx.errors.status_not_found', index: index,
                                                                                     code: status_code.split('#')[1])
      end

      def valid_row_types!(row, index)
        pt = property_types[row['tipo-propiedad']]

        if pt.blank?
          raise ActiveRecord::RecordNotFound,
                I18n.t('services.properties.import.read_xlsx.errors.property_type_not_found',
                       name: row['tipo-propiedad'],
                       index: index)
        end

        return if pt.location_regex_valid?(row['localizacion'])

        raise ActiveRecord::RecordNotFound,
              I18n.t('services.properties.import.read_xlsx.errors.invalid_location',
                     location: row['localizacion'],
                     index: index)
      end

      def workbook
        @workbook ||= Roo::Spreadsheet.open(file.path)
      end

      def status_keys
        @status_keys ||= header.select { |key| key.include?('#') }
      end

      def header
        @header ||= workbook.row(1)
      end

      def statuses
        @statuses ||= Status.all_of_properties(I18n.locale.to_s).index_by(&:code)
      end

      def property_types
        @property_types ||= PropertyType.active.index_by(&:name)
      end
    end
  end
end
