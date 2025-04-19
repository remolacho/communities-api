# frozen_string_literal: true

module Menus
  module Dashboard
    module Items
      class PqrGraphItem
        attr_accessor :user

        def initialize(user:)
          @user = user
        end

        def perform
          {
            pqr_graph: {
              code: 'pqr_graph',
              show: true
            }
          }
        end
      end
    end
  end
end
