# frozen_string_literal: true

class Menus::Suggestions::Items::SelfListItem
  attr_accessor :user

  def initialize(user:)
    @user = user
  end

  def perform
    {
      selfSuggestions: {
        code: 'selfSuggestions',
        show: true
      }
    }
  end
end
