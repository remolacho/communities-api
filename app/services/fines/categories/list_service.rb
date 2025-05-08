# frozen_string_literal: true

module Fines
  module Categories
    class ListService
      attr_accessor :user, :page

      def initialize(user:, page: 1)
        @user = user
        @page = page
      end

      def hierarchy
        @hierarchy ||= CategoryFine.with_recursive_children(roots.pluck(:id))
      end

      def roots
        @roots ||= CategoryFine
          .active
          .roots
          .page(page.to_i)
      end
    end
  end
end
