# frozen_string_literal: true

module Menus
  module Fines
    module Items
      class CategoriesItem < ::CategoriesFines::Policy
        def initialize(user:)
          super(current_user: user)
        end

        def perform
          {
            categories_fine_list: {
              code: 'categories_fine_list',
              show: can_show?
            }
          }
        end

        private

        def can_show?
          @can_show ||= role?(:can_read)
        end
      end
    end
  end
end
