# frozen_string_literal: true

class Petitions::List::ListGroupRolesService
  attr_accessor :user, :filter, :page

  def initialize(user:, filter:, page: 1)
    @user = user
    @filter = filter
    @page = page
  end

  def call
    policy.can_read!

    Petition.includes(:user, :status, :category_petition)
      .where(group_role_id: group_roles_ids)
      .ransack(filter.call)
      .result
      .order(updated_at: :desc)
      .page(page.to_i)
  end

  private

  def policy
    @policy ||= ::Petitions::List::Policy.new(current_user: user)
  end

  def group_roles_ids
    @group_roles_ids ||= GroupRoleRelation.where(role_id: user_roles_ids).pluck(:group_role_id).uniq
  end

  def user_roles_ids
    @user_roles_ids ||= user.roles.ids
  end
end
