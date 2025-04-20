# frozen_string_literal: true

module Menus
  module Pqrs
    module Items
      class ListItem < ::Petitions::List::Policy
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
