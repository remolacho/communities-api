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
          .merge!(list_item.perform)
          .merge!(create_item.perform)
          .merge!(import_item.perform)
      end

      def can_show?
        @can_show ||= items.values.any? { |item| item[:show] }
      end

      def list_item
        Items::CategoriesItem.new(user: user)
      end

      def create_item
        Items::CreateCategoryItem.new(user: user)
      end

      def import_item
        Items::ImportCategoryItem.new(user: user)
      end
    end
  end
end
