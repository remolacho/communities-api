# frozen_string_literal: true

class UserRoles::Import::CreateService
  attr_accessor :file, :user, :enterprise

  def initialize(enterprise:, user:, file:)
    @enterprise = enterprise
    @user = user
    @file = file
  end

  def perform
    valid_file!
    valid_header!
  end

  private

  def valid_file!
    raise ArgumentError, I18n.t('services.user_roles.import.create.error.file_nil') unless file.present?
    raise ArgumentError, I18n.t('services.user_roles.import.create.error.file_ext') unless extension.eql?('xlsx')
    raise ArgumentError, I18n.t('services.user_roles.import.create.error.file_not_found') if read_xlsx.nil?
  end

  def valid_header!
    raise ArgumentError, I18n.t('services.user_roles.import.create.error.header.not_allowed') if header.size < 2
    raise ArgumentError, I18n.t('services.user_roles.import.create.error.header.identifier') unless header.include?('identifier')
  end

  def header
    @header ||= xlsx.shift
  end
  def xlsx
    @xlsx ||= read_xlsx.parse
  end

  def read_xlsx
    @read_xlsx ||= (Roo::Spreadsheet.open file.tempfile.path, extension: extension) rescue nil
  end

  def extension
    @extension ||= file.original_filename.split('.').last
  end

  def allowed_header
    @header = ['identifier'] + roles_slug
  end

  def roles_slug
    @roles_slug ||= Role.order(:slug).pluck(:slug)
  end
end
