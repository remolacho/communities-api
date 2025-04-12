# frozen_string_literal: true

class Enterprises::Profile::Policy < BasePolicy
  def initialize(current_user:)
    super
  end

  def can_read!
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
    @group_role ||= GroupRole.find_by(code: :show_enterprise, entity_type: Enterprise::ENTITY_TYPE)
  end

  def user_roles_ids
    @user_roles_ids ||= current_user.roles.ids
  end
end
