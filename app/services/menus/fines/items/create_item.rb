# frozen_string_literal: true

module Menus
  module Fines
    module Items
      class CreateItem < ::Fines::Policy
        attr_accessor :user

        def initialize(user:)
          super(current_user: user)
        end

        def perform
          {
            create_fine: {
              code: 'create_fine',
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
