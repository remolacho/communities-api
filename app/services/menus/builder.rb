# frozen_string_literal: true

module Menus
  class Builder
    attr_accessor :user,
                  :dashboard_item,
                  :enterprise_item,
                  :users_item,
                  :suggestions_item,
                  :pqrs_item

    def build
      menu = init_menu
      menu.merge!(dashboard_item.perform)
      menu.merge!(enterprise_item.perform)
      menu.merge!(users_item.perform)
      menu.merge!(suggestions_item.perform)
      menu.merge!(pqrs_item.perform)
      menu
    end

    private

    def init_menu
      {}
    end
  end
end
