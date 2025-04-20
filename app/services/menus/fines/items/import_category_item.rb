# frozen_string_literal: true

module Menus
  module Fines
    module Items
      class ImportCategoryItem < ::CategoriesFines::Policy
        def initialize(user:)
          super(current_user: user)
        end

        def perform
          {
            import: {
              code: 'import',
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
