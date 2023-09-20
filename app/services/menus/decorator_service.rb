# frozen_string_literal: true

class Menus::DecoratorService
  attr_accessor :user

  def initialize(user:)
    @user = user
  end

  def build
    @menu = ::Menus::Builder.new
    @menu.dashboard_item   = ::Menus::Dashboard::ItemService.new(user: user)
    @menu.enterprise_item  = ::Menus::Enterprise::ItemService.new(user: user)
    @menu.users_item       = ::Menus::Users::ItemService.new(user: user)
    @menu.suggestions_item = ::Menus::Suggestions::ItemService.new(user: user)
    @menu.pqrs_item        = ::Menus::Pqrs::ItemService.new(user: user)
    @menu.build
  end
end
