# frozen_string_literal: true

class Petitions::ListService
  attr_accessor :user, :filter

  def initialize(user:, filter:)
    @user = user
    @filter = filter
  end

  def call(page = 1)
    raise PolicyException unless user_roles_ids.present?
    raise PolicyException unless group_roles_ids.present?

    petitions.includes(:user).ransack(search.call).result.page(page.to_i)
  end

  private

  def petitions
    @petitions ||= Petition.where(group_role_id: group_roles_ids)
  end

  def group_roles_ids
    @group_roles_ids ||= GroupRoleRelation.where(role_id: user_roles_ids).pluck(:group_role_id).uniq
  end

  def user_roles_ids
    @user_roles_ids ||= user.roles.ids
  end

  def search
    @search ||= Petitions::Searches::QueryTermService.new(filter: filter)
  end
end
