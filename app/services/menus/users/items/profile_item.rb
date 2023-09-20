# frozen_string_literal: true

class Menus::Users::Items::ProfileItem
  attr_accessor :user

  def initialize(user:)
    @user = user
  end

  def perform
    {
      profile: {
        code: 'profile',
        show: true
      }
    }
  end
end