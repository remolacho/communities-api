# frozen_string_literal: true

class Users::List::Policy < ::BasePolicy
  attr_accessor :enterprise

  def initialize(current_user:, enterprise:)
    super(current_user: current_user)

    @enterprise = enterprise
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
    @group_role ||= GroupRole.find_by(code: :listed_users, entity_type: User::ENTITY_TYPE)
  end

  def user_roles_ids
    @user_roles_ids ||= current_user.roles.ids
  end
end
