# frozen_string_literal: true

class Suggestions::List::ListGroupRolesService
  attr_accessor :user, :filter, :page

  def initialize(user:, filter:, page: 1)
    @user = user
    @filter = filter
    @page = page
  end

  def call
    policy.can_read!

    Suggestion.includes(:user)
              .ransack(filter.call)
              .result
              .order(updated_at: :desc)
              .page(page.to_i)
  end

  private

  def policy
    @policy ||= ::Suggestions::List::Policy.new(current_user: user)
  end
end
