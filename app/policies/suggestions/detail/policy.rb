# frozen_string_literal: true

class Suggestions::Detail::Policy < ::BasePolicy
  attr_accessor :suggestion

  def initialize(current_user:, suggestion:)
    super(current_user: current_user)

    @suggestion = suggestion
  end

  def can_read!
    loudly do
      is_owner? || has_role?
    end
  end

  private

  def is_owner?
    current_user.id == suggestion.user_id
  end

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
