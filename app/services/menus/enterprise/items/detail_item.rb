# frozen_string_literal: true

module Menus
  module Enterprise
    module Items
      class DetailItem < ::Enterprises::Profile::Policy
        def initialize(user:)
          super(current_user: user)
        end

        def perform
          {
            detail: {
              code: 'detail',
              show: can_show?
            }
          }
        end

        def can_show?
          @can_show ||= role?(:can_read)
        end
      end
    end
  end
end
