# frozen_string_literal: true

module Menus
  module Properties
    class ItemService
      attr_accessor :user

      def initialize(user:)
        @user = user
      end

      def perform
        {
          properties: {
            code: 'properties',
            show: can_show?,
            items: items
          }
        }
      end

      private

      def items
        @items ||= {}
          .merge!(list_item.perform)
      end

      def list_item
        Items::ListPropertiesItem.new(user: user)
      end

      def can_show?
        @can_show ||= items.values.any? { |item| item[:show] }
      end
    end
  end
end
