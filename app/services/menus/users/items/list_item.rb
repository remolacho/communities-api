# frozen_string_literal: true

module Menus
  module Users
    module Items
      class ListItem < ::Users::List::Policy
        def initialize(user:)
          super(current_user: user, enterprise: user.enterprise)
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
          @can_show ||= role?
        end
      end
    end
  end
end
