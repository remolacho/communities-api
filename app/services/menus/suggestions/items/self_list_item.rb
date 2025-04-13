# frozen_string_literal: true

module Menus
  module Suggestions
    module Items
      class SelfListItem
        attr_accessor :user

        def initialize(user:)
          @user = user
        end

        def perform
          {
            selfSuggestions: {
              code: 'selfSuggestions',
              show: true
            }
          }
        end
      end
    end
  end
end
