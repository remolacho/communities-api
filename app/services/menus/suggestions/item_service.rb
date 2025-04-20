# frozen_string_literal: true

module Menus
  module Suggestions
    class ItemService
      attr_accessor :user

      def initialize(user:)
        @user = user
      end

      def perform
        {
          suggestions: {
            code: 'suggestions',
            show: can_show?,
            items: items
          }
        }
      end

      private

      def items
        @items ||= {}.merge!(create_item.perform)
          .merge!(self_list.perform)
          .merge!(list_item.perform)
      end

      def can_show?
        @can_show ||= items.values.any? { |item| item[:show] }
      end

      def create_item
        Items::CreateItem.new(user: user)
      end

      def self_list
        Items::SelfListItem.new(user: user)
      end

      def list_item
        Items::ListItem.new(user: user)
      end
    end
  end
end
