# frozen_string_literal: true

module Menus
  module Dashboard
    class ItemService
      attr_accessor :user

      def initialize(user:)
        @user = user
      end

      def perform
        {
          dashboard: {
            code: 'dashboard',
            show: true,
            items: items
          }
        }
      end

      private

      def items
        @items ||= {}.merge!(pqr_graph_item.perform)
      end

      def pqr_graph_item
        Items::PqrGraphItem.new(user: user)
      end
    end
  end
end
