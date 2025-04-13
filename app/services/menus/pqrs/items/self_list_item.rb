# frozen_string_literal: true

module Menus
  module Pqrs
    module Items
      class SelfListItem
        attr_accessor :user

        def initialize(user:)
          @user = user
        end

        def perform
          {
            selfPqrs: {
              code: 'selfPqrs',
              show: true
            }
          }
        end
      end
    end
  end
end
