# frozen_string_literal: true

require 'roo'

module UserProperties
  module Import
    class ReadXlsx
      REQUIRED_HEADERS = ['identificador', 'localizacion'].freeze

      attr_reader :file, :workbook, :sheet

      def initialize(file:)
        @file = file
        @workbook = Roo::Spreadsheet.open(file)
        @sheet = workbook.sheet(0)
      end

      def call
        header!

        read_content
      end

      private

      def read_content
        (2..sheet.last_row).map do |i|
          header.zip(sheet.row(i)).to_h
        end
      end

      def header!
        @header ||= header
      end

      def header
        @header ||= validate_header
      end

      def validate_header
        header = sheet.row(1).map(&:downcase).sort

        unless header == REQUIRED_HEADERS.sort
          raise ArgumentError,
                I18n.t('services.user_properties.import.read_xlsx.errors.invalid_header')
        end

        header
      end
    end
  end
end
