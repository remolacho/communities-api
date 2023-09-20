# frozen_string_literal: true

class Users::Profile::Policy < ::BasePolicy
  attr_accessor :profile

  def initialize(current_user:, profile:)
    super(current_user: current_user)

    @profile = profile
  end

  def can_read!
    loudly do
      owner? || has_role?
    end
  end

  private

  def owner?
    current_user.id == profile.id
  end

  def has_role?
    group_role.present? && !group_role_relations.zero?
  end

  def group_role_relations
    @group_role_relations ||= group_role.group_role_relations.where(role_id: user_roles_ids).count
  end

  def group_role
    @group_role ||= GroupRole.find_by(code: :show_user, entity_type: User::ENTITY_TYPE)
  end

  def user_roles_ids
    @user_roles_ids ||= current_user.roles.ids
  end
end
