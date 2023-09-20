# frozen_string_literal: true

class UserRoles::Import::Remove::Policy < ::BasePolicy
  def initialize(current_user:)
    super(current_user: current_user)
  end

  def can_write!
    loudly do
      has_role?
    end
  end

  private

  def has_role?
    group_role.present? && !group_role_relations.zero?
  end

  def group_role_relations
    @group_role_relations ||= group_role.group_role_relations.where(role_id: user_roles_ids).count
  end

  def group_role
    @group_role ||= GroupRole.find_by(code: :remove_user_roles, entity_type: UserRole::ENTITY_TYPE)
  end

  def user_roles_ids
    @user_roles_ids ||= current_user.roles.ids
  end
end
