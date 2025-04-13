# frozen_string_literal: true

module BaseZero
  class CreateGroupRoleRelationsService
    def initialize
      @relations = Shared::GroupRolesList.relations
    end

    def call
      create_group_role_relations
    end

    private

    attr_reader :relations

    def create_group_role_relations
      relations.each_value do |group_roles|
        group_roles.each do |group_role_code, role_codes|
          group_role = GroupRole.find_by!(code: group_role_code)
          role_codes.each do |role_code|
            role = Role.find_by!(code: role_code)
            GroupRoleRelation.find_or_create_by!(
              group_role: group_role,
              role: role
            )
          end
        end
      end
    end
  end
end
