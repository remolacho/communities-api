# frozen_string_literal: true

module Fines
  module Categories
    class DeactivateService
      attr_reader :user, :category, :enterprise

      def initialize(user:, category:)
        @user = user
        @category = category
        @enterprise = user.enterprise
      end

      def call
        deactivate_category_and_descendants
      end

      private

      def deactivate_category_and_descendants
        categories_to_deactivate = CategoryFine.with_recursive_children([category.id])

        CategoryFine.where(id: categories_to_deactivate.map(&:id))
          .update_all(
            active: false,
            updated_at: Time.current
          )
      end
    end
  end
end
