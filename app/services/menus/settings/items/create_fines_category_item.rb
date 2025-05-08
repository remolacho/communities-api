# frozen_string_literal: true

module Menus
  module Settings
    module Items
      class CreateFinesCategoryItem < ::CategoriesFines::Policy
        def initialize(user:)
          super(current_user: user)
        end

        def perform
          {
            fines_category_create: {
              code: 'fines_category_create',
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
