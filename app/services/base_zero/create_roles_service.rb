# frozen_string_literal: true

module BaseZero
  class CreateRolesService
    def initialize
      @roles = Shared::RolesList.all
    end

    def call
      create_roles
    end

    private

    attr_reader :roles

    def create_roles
      roles.each do |role_code, role_name|
        Role.find_or_create_by!(
          code: role_code,
          name: role_name,
          slug: role_name.parameterize
        )
      end
    end
  end
end
