# frozen_string_literal: true

module Properties
  module Template
    class StructureService
      attr_accessor :user

      def initialize(user:)
        @user = user
      end

      def call
        {
          import_sheet: import_sheet_headers,
          types_sheet: types_sheet_structure
        }
      end

      private

      def types_sheet_structure
        rows = [
          ['Tipo de propiedad', 'Localización (Nomenclatura)']
        ]

        rows | property_types.map { |type| [type.name, type.placeholder] }
      end

      def import_sheet_headers
        ['tipo-propiedad', 'localización'] | status_headers
      end

      def status_headers
        Status.all_of_properties(I18n.locale.to_s)
          .map { |status| "#{status.as_name}##{status.code}" }
      end

      def property_types
        @property_types ||= PropertyType.active
          .where(enterprise: user.enterprise)
      end
    end
  end
end
