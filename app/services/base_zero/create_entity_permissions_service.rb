# frozen_string_literal: true

module BaseZero
  class CreateEntityPermissionsService
    attr_reader :roles

    def initialize
      @roles = Role.all
    end

    def call
      roles_admins
      roles_other
    end

    private

    def entities
      @entities ||= Dir[Rails.root.join('app/models/**/*.rb')].map do |file|
        next if file.include?('application_record.rb') || file.include?('concerns/')

        require_dependency file unless File.basename(file, '.rb').camelize.safe_constantize

        File.basename(file, '.rb').camelize
      end.compact
    end

    def roles_admins
      @roles_admins ||= Role.where(code: ['super_admin', 'admin']).each do |role|
        entities.each do |entity|
          role.entity_permissions.find_or_create_by!(entity_type: entity) do |ep|
            ep.can_read = true
            ep.can_write = true
            ep.can_destroy = true
            ep.can_change_status = true
          end
        end
      end
    end

    def roles_other
      @roles_other ||= Role.where.not(code: ['super_admin', 'admin']).each do |role|
        entities.each do |entity|
          role.entity_permissions.find_or_create_by!(entity_type: entity) do |ep|
            ep.can_read = false
            ep.can_write = false
            ep.can_destroy = false
            ep.can_change_status = false
          end
        end
      end
    end
  end
end
