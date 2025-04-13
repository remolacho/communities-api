# frozen_string_literal: true

module Suggestions
  module List
    class ListOwnService
      attr_accessor :user, :filter, :page

      def initialize(user:, filter:, page: 1)
        @user = user
        @filter = filter
        @page = page
      end

      def call
        user.suggestions
          .includes(:user)
          .ransack(filter.call)
          .result
          .order(updated_at: :desc)
          .page(page.to_i)
      end
    end
  end
end
