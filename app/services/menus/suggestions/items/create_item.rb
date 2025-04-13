# frozen_string_literal: true

module Menus
  module Suggestions
    module Items
      class CreateItem
        attr_accessor :user

        def initialize(user:)
          @user = user
        end

        def perform
          {
            create: {
              code: 'create',
              show: true
            }
          }
        end
      end
    end
  end
end
