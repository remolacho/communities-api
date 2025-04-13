# frozen_string_literal: true

module Users
  class ListService
    attr_accessor :user, :enterprise, :search

    def initialize(user:, enterprise:, search:)
      @user = user
      @enterprise = enterprise
      @search = search
    end

    def call(page = 1)
      enterprise.users
        .includes(:user_enterprise)
        .ransack(search.call)
        .result.page(page.to_i)
    end
  end
end
