# frozen_string_literal: true

class Menus::Dashboard::ItemService
  attr_accessor :user

  def initialize(user:)
    @user = user
  end

  def perform
    {
      dashboard: {
        code: 'dashboard',
        show: true
      }
    }
  end
end
