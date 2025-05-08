# frozen_string_literal: true

module Menus
  class DecoratorService
    attr_accessor :user

    def initialize(user:)
      @user = user
    end

    def build
      @menu = Builder.new
      @menu.dashboard_item   = Dashboard::ItemService.new(user: user)
      @menu.enterprise_item  = Enterprise::ItemService.new(user: user)
      @menu.users_item       = Users::ItemService.new(user: user)
      @menu.suggestions_item = Suggestions::ItemService.new(user: user)
      @menu.pqrs_item        = Pqrs::ItemService.new(user: user)
      @menu.fines_item       = Fines::ItemService.new(user: user)
      @menu.properties_item  = Properties::ItemService.new(user: user)
      @menu.settings_item    = Settings::ItemService.new(user: user)
      @menu.build
    end
  end
end
