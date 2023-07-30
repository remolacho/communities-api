# frozen_string_literal: true

class Petitions::List::FactoryService
  attr_accessor :user, :filter

  def initialize(user:, filter:)
    @user = user
    @filter = filter
  end

  def call(page = 1)
    raise PolicyException unless user_roles_ids.present?
  end

  private

  def user_roles_ids
    @user_roles_ids ||= user.roles.ids
  end
end

