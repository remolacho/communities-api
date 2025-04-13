# frozen_string_literal: true

module Menus
  module Users
    module Items
      class ProfileItem
        attr_accessor :user

        def initialize(user:)
          @user = user
        end

        def perform
          {
            profile: {
              code: 'profile',
              show: true
            }
          }
        end
      end
    end
  end
end
