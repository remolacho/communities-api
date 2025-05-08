# frozen_string_literal: true

module Menus
  module Settings
    module Items
      class ImportPropertiesItem < ::Properties::Policy
        def initialize(user:)
          super(current_user: user)
        end

        def perform
          {
            import_properties: {
              code: 'import_properties',
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
