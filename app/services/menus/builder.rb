# frozen_string_literal: true

module Menus
  class Builder
    attr_accessor :user,
                  :dashboard_item,
                  :enterprise_item,
                  :users_item,
                  :suggestions_item,
                  :pqrs_item,
                  :fines_item,
                  :properties_item,
                  :settings_item

    def build
      menu = init_menu
      menu.merge!(dashboard_item.perform)
      menu.merge!(enterprise_item.perform)
      menu.merge!(users_item.perform)
      menu.merge!(suggestions_item.perform)
      menu.merge!(pqrs_item.perform)
      menu.merge!(fines_item.perform)
      menu.merge!(properties_item.perform)
      menu.merge!(settings_item.perform)
    end

    private

    def init_menu
      {}
    end
  end
end
