# frozen_string_literal: true

class Menus::Pqrs::Items::SelfListItem
  attr_accessor :user

  def initialize(user:)
    @user = user
  end

  def perform
    {
      selfPqrs: {
        code: 'selfPqrs',
        show: true
      }
    }
  end
end
