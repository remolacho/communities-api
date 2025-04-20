# frozen_string_literal: true

module Menus
  module Enterprise
    class ItemService
      attr_reader :current_user

      def initialize(user:)
        @current_user = user
      end

      def perform
        {
          enterprise: {
            code: 'enterprise',
            show: can_show?,
            items: items
          }
        }
      end

      private

      def items
        @items ||= {}.merge!(detail_item.perform)
          .merge!(edit_item.perform)
      end

      def can_show?
        @can_show ||= items.values.any? { |item| item[:show] }
      end

      def detail_item
        Items::DetailItem.new(user: current_user)
      end

      def edit_item
        Items::EditItem.new(user: current_user)
      end
    end
  end
end
