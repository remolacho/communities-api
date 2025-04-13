# frozen_string_literal: true

module Menus
  module Pqrs
    class ItemService
      attr_accessor :user

      def initialize(user:)
        @user = user
      end

      def perform
        {
          pqrs: {
            code: 'pqrs',
            show: true,
            items: items
          }
        }
      end

      private

      def items
        {}.merge!(create_item.perform)
          .merge!(self_list.perform)
          .merge!(list_item.perform)
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
