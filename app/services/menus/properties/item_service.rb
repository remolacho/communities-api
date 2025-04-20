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
          .merge!(import_item.perform)
      end

      def import_item
        Items::ImportPropertiesItem.new(user: user)
      end

      def can_show?
        @can_show ||= items.values.any? { |item| item[:show] }
      end
    end
  end
end
