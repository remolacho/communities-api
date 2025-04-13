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
            show: true
          }
        }
      end
    end
  end
end
