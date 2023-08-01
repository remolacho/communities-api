# frozen_string_literal: true

class UserRoles::Templates::ImportService
  attr_accessor :enterprise

  def initialize(enterprise:)
    @enterprise = enterprise
  end

  def build
    Struct.new(:name_file, :file).new(name_file, create_file)
  end

  private

  def create_file
    user_roles = Axlsx::Package.new
    workbook = user_roles.workbook
    generic_header_style = workbook.styles.add_style(b: true, sz: 13)

    workbook.add_worksheet(name: 'roles') do |sheet|
      sheet.add_row(header, style: generic_header_style, height: 17)
    end

    user_roles
  end

  def name_file
    "#{enterprise.subdomain}-import-user-roles.xlsx"
  end

  def header
    @header = ['identifier'] + roles_slug
  end

  def roles_slug
    @roles_slug ||= Role.order(:slug).pluck(:slug)
  end
end
