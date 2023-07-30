# frozen_string_literal: true

class Users::ListService
  attr_accessor :user, :enterprise, :search_term, :attr

  def initialize(user:, enterprise:, attr:, search_term:)
    @user = user
    @enterprise = enterprise
    @search_term = search_term
    @attr = attr
  end

  def call(page = 1)
    policy.can_read!

    enterprise.users.ransack(search.call).result.page(page.to_i)
  end

  private

  def search
    @search ||= Users::Searches::QueryTermService.new(attr: attr ,term: search_term)
  end

  def policy
    ::Users::List::Policy.new(current_user: user, enterprise: enterprise)
  end
end
