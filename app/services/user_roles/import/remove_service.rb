# frozen_string_literal: true

module UserRoles
  module Import
    class RemoveService
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

        remove_roles
      end

      private

      def remove_roles
        data_hash = []
        xlsx.select(&:any?).drop(1).each { |row| data_hash << header.zip(row).to_h }
        roles_index = current_roles.index_by(&:slug)

        data_hash.each do |data|
          next unless data['identifier'].present?

          user_h = enterprise.users.find_by(identifier: clean_identifier(data['identifier']))
          unless user_h.present?
            next errors << I18n.t('services.user_roles.import.remove.error.user_not_found',
                                  identifier: data['identifier'])
          end

          user_roles_array = { user_ids: [], role_ids: [] }

          data.each do |key_role, value|
            next if key_role.eql?('identifier')
            next unless value.present?

            role = roles_index[key_role]
            next unless role.present?

            user_roles_array[:user_ids] << user_h.id
            user_roles_array[:role_ids] << role.id
          end

          delete_all_roles(user_roles_array)
        end

        errors
      end

      def delete_all_roles(user_roles_array)
        UserRole.where(user_id: user_roles_array[:user_ids].uniq,
                       role_id: user_roles_array[:role_ids].uniq).delete_all
      end

      def valid_file!
        raise ArgumentError, I18n.t('services.user_roles.import.remove.error.file_nil') unless file.present?
        raise ArgumentError, I18n.t('services.user_roles.import.remove.error.file_ext') unless extension.eql?('xlsx')
        raise ArgumentError, I18n.t('services.user_roles.import.remove.error.file_not_found') if read_xlsx.nil?
      end

      def valid_header!
        raise ArgumentError, I18n.t('services.user_roles.import.remove.error.header.not_allowed') if header.size < 2

        unless header.include?('identifier')
          raise ArgumentError,
                I18n.t('services.user_roles.import.create.error.header.identifier')
        end
        return if header_roles[:empty]

        raise ArgumentError,
              I18n.t('services.user_roles.import.create.error.header.roles',
                     fields: header_roles[:fields])
      end

      def header
        @header ||= xlsx.first
      end

      def xlsx
        @xlsx ||= read_xlsx
      end

      def read_xlsx
        @read_xlsx ||= begin
          (Roo::Spreadsheet.open file.tempfile.path, extension: extension)
        rescue StandardError
          nil
        end
      end

      def extension
        @extension ||= file.original_filename.split('.').last
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

      def clean_identifier(value)
        value.to_s.clean_identifier
      end
    end
  end
end
