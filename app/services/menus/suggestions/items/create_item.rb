# frozen_string_literal: true

class Menus::Suggestions::Items::CreateItem
  attr_accessor :user

  def initialize(user:)
    @user = user
  end

  def perform
    {
      create: {
        code: 'create',
        show: true
      }
    }
  end
end
