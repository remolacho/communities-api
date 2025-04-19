# frozen_string_literal: true

module Menus
  module Fines
    class ItemService
      attr_accessor :user

      def initialize(user:)
        @user = user
      end

      def perform
        {
          fines: {
            code: 'fines',
            show: can_show?,
            items: items
          }
        }
      end

      private

      def items
        @items ||= {}
          .merge!(categories_fine_list_item.perform)
          .merge!(create_fine_item.perform)
      end

      def can_show?
        @can_show ||= items.values.any? { |item| item[:show] }
      end

      def categories_fine_list_item
        Items::CategoriesItem.new(user: user)
      end

      def create_fine_item
        Items::CreateItem.new(user: user)
      end
    end
  end
end
