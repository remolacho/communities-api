# frozen_string_literal: true

module Menus
  module Suggestions
    module Items
      class ListItem < ::Suggestions::List::Policy
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
          @can_show ||= has_role?
        end
      end
    end
  end
end
