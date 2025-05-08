# frozen_string_literal: true

module Menus
  module Settings
    class ItemService
      attr_accessor :user

      def initialize(user:)
        @user = user
      end

      def perform
        {
          settings: {
            code: 'settings',
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
        @items ||= {}.merge!(assign_roles.perform)
          .merge!(remove_roles.perform)
          .merge!(import_properties.perform)
          .merge!(create_fines_category.perform)
          .merge!(import_fines_category.perform)
      end

      def assign_roles
        Items::AssignRolesItem.new(user: user)
      end

      def remove_roles
        Items::RemoveRolesItem.new(user: user)
      end

      def import_properties
        Items::ImportPropertiesItem.new(user: user)
      end

      def create_fines_category
        Items::CreateFinesCategoryItem.new(user: user)
      end

      def import_fines_category
        Items::ImportFinesCategoryItem.new(user: user)
      end
    end
  end
end
