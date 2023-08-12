# frozen_string_literal: true

class UserRoles::Import::CreateService
  attr_accessor :file, :user, :enterprise, :errors

  def initialize(enterprise:, user:, file:)
    @enterprise = enterprise
    @user = user
    @file = file
    @errors = []
  end

  def perform
    valid_file!
    valid_header!

    create_roles
  end

  private

  def create_roles
    data_hash = []
    xlsx.select(&:any?).each { |row| data_hash << header.zip(row).to_h }
    roles_index = current_roles.index_by(&:slug)

    data_hash.each do |data|
      next unless data['identifier'].present?

      user_h =  enterprise.users.find_by(identifier: clean_identifier(data['identifier']))
      next errors << I18n.t('services.user_roles.import.create.error.user_not_found', identifier: data['identifier']) unless user_h.present?

      user_roles_array = data.map do |key_role, value|
        next if key_role.eql?('identifier')
        next unless value.present?

        role = roles_index[key_role]
        next unless role.present?

        { user_id:  user_h.id, role_id: role.id, created_by: user.id}
      end.compact

      insert_all_roles(user_roles_array)
    end

    errors
  end

  def insert_all_roles(user_roles_array)
    UserRole.insert_all(user_roles_array,
                        unique_by: %i[user_id role_id],
                        returning: %i[role_id])
  end

  def valid_file!
    raise ArgumentError, I18n.t('services.user_roles.import.create.error.file_nil') unless file.present?
    raise ArgumentError, I18n.t('services.user_roles.import.create.error.file_ext') unless extension.eql?('xlsx')
    raise ArgumentError, I18n.t('services.user_roles.import.create.error.file_not_found') if read_xlsx.nil?
  end

  def valid_header!
    raise ArgumentError, I18n.t('services.user_roles.import.create.error.header.not_allowed') if header.size < 2
    raise ArgumentError, I18n.t('services.user_roles.import.create.error.header.identifier') unless header.include?('identifier')
    raise ArgumentError, I18n.t('services.user_roles.import.create.error.header.roles', fields: header_roles[:fields]) unless header_roles[:empty]
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

  def header_roles
    return @header_roles unless @header_roles.nil?

    roles_s = current_roles.pluck(:slug)
    result = (header[1..] - roles_s)

    @header_roles = {
      empty: result.empty?,
      fields: result.join(',')
    }
  end

  def current_roles
    @current_roles ||= Role.where(slug: header[1..]).order(:slug)
  end

  def roles_slug
    @roles_slug ||= Role.order(:slug).pluck(:slug)
  end

  def clean_identifier(value)
    return value if value.class.eql?(String)

    str = value.to_s.strip.downcase
    str.split('.').first
  end
end
