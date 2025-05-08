# frozen_string_literal: true

module BaseZero
  class CreateGroupRolesService
    def initialize
      @group_roles = Shared::GroupRolesList.all
    end

    def call
      create_group_roles
    end

    private

    attr_reader :group_roles

    def create_group_roles
      group_roles.each do |group_role|
        GroupRole.find_or_create_by(
          code: group_role[:code],
          entity_type: group_role[:entity_type]
        ) do |group|
          group.name = group_role[:name]
        end
      end
    end
  end
end
