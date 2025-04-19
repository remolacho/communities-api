# frozen_string_literal: true

module Menus
  module Properties
    module Items
      class ListPropertiesItem < ::Properties::Policy
        def initialize(user:)
          super(current_user: user)
        end

        def perform
          {
            list: {
              code: 'list',
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
