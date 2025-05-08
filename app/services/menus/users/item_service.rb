# frozen_string_literal: true

module Menus
  module Users
    class ItemService
      attr_accessor :user

      def initialize(user:)
        @user = user
      end

      def perform
        {
          users: {
            code: 'users',
            show: can_show?,
            items: items
          }
        }
      end

      private

      def can_show?
        @can_show ||= items.values.any? { |item| item[:show] }
      end

      def items
        @items ||= {}.merge!(list_item.perform)
          .merge!(profile_item.perform)
      end

      def profile_item
        Items::ProfileItem.new(user: user)
      end

      def list_item
        Items::ListItem.new(user: user)
      end
    end
  end
end
