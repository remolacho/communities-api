# frozen_string_literal: true

module Menus
  module Enterprise
    class ItemService < ::Enterprises::Profile::Policy
      def initialize(user:)
        super(current_user: user)
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
        {}.merge!(detail_item.perform)
          .merge!(edit_item.perform)
      end

      def detail_item
        Items::DetailItem.new(user: current_user, can_show: can_show?)
      end

      def edit_item
        Items::EditItem.new(user: current_user)
      end

      def can_show?
        @can_show ||= has_role?
      end
    end
  end
end
