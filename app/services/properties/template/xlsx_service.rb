# frozen_string_literal: true

module Properties
  module Template
    class XlsxService
      attr_accessor :structure

      def initialize(structure:)
        @structure = structure
      end

      def call
        package = Axlsx::Package.new
        workbook = package.workbook

        add_import_sheet(workbook, structure[:import_sheet])
        add_types_sheet(workbook, structure[:types_sheet])

        package
      end

      private

      def add_import_sheet(workbook, headers)
        workbook.add_worksheet(name: 'Importar Propiedades') do |sheet|
          sheet.add_row(headers, style: header_style(workbook))
        end
      end

      def add_types_sheet(workbook, data)
        workbook.add_worksheet(name: 'Tipos y Nomenclatura') do |sheet|
          add_legend(sheet, workbook)

          2.times { sheet.add_row([]) }

          sheet.add_row(data.first, style: header_style(workbook))
          data[1..].each do |row|
            sheet.add_row(row)
          end

          sheet.column_widths 30, 40
        end
      end

      def add_legend(sheet, workbook)
        title_style = workbook.styles.add_style(
          b: true,
          sz: 12,
          fg_color: '000000'
        )

        text_style = workbook.styles.add_style(
          sz: 11,
          alignment: { indent: 1 }
        )

        sheet.add_row(['Instrucciones de Uso'], style: title_style)
        sheet.add_row([])

        sheet.add_row(['1. En la hoja "Importar Propiedades":'], style: title_style)
        sheet.add_row(['• Marque con una X el estado que corresponda a la propiedad'], style: text_style)
        sheet.add_row(['• Se tomará en cuenta el primer estado marcado con X'], style: text_style)
        sheet.add_row(['• La localización debe seguir exactamente el formato según el tipo de propiedad'],
                      style: text_style)
        sheet.add_row([])

        sheet.add_row(['2. En esta hoja:'], style: title_style)
        sheet.add_row(['• Encontrará todos los tipos de propiedades disponibles'], style: text_style)
        sheet.add_row(['• Use exactamente el formato de localización mostrado para cada tipo'], style: text_style)
      end

      def header_style(workbook)
        workbook.styles.add_style(
          bg_color: '4F81BD',
          fg_color: 'FFFFFF',
          b: true,
          alignment: { horizontal: :center }
        )
      end
    end
  end
end
