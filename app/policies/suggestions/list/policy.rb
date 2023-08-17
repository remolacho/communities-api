# frozen_string_literal: true

class Suggestions::List::Policy < ::BasePolicy

  def initialize(current_user:)
    super(current_user: current_user)
  end

  def can_read!
    loudly do
       has_role?
    end
  end

  private

  def has_role?
    group_role.present? && group_role_relations.present?
  end

  def group_role_relations
    @group_role_relations ||= group_role.group_role_relations.where(role_id: user_roles_ids)
  end

  def group_role
    @group_role ||= GroupRole.find_by(code: :view_suggestions)
  end

  def user_roles_ids
    @user_roles_ids ||= current_user.roles.ids
  end
end
