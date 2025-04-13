# frozen_string_literal: true

module Menus
  module Properties
    module Items
      class ImportPropertiesItem < ::Properties::Policy
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
