# frozen_string_literal: true

module Fines
  module Categories
    class ListService
      attr_accessor :user, :page

      def initialize(user:, page: 1)
        @user = user
        @page = page
      end

      def call
        root_ids = categories.pluck(:id)
        CategoryFine.with_recursive_children(root_ids)
      end

      private

      def categories
        @categories ||= CategoryFine
          .active
          .roots
          .page(page.to_i)
      end
    end
  end
end
