# frozen_string_literal: true

class Properties::Templates::AssignService
  attr_accessor :enterprise

  def initialize(enterprise:)
    @enterprise = enterprise
  end

  def build
    Struct.new(:name_file, :file).new(name_file, create_file)
  end

  private

  def create_file
    properties = Axlsx::Package.new
    workbook = properties.workbook
    generic_header_style = workbook.styles.add_style(b: true, sz: 13)

    workbook.add_worksheet(name: 'propiedades') do |sheet|
      sheet.add_row(header, style: generic_header_style, height: 17)
    end

    properties
  end

  def name_file
    "#{enterprise.subdomain}-assign-properties.xlsx"
  end

  def header
    @header = ['propiedad', 'atributo', 'alias',	'prefijo',	'rango_min',	'rango_max']
  end
end
