# frozen_string_literal: true

module Menus
  module Enterprise
    module Items
      class EditItem < ::Enterprises::Update::Policy
        def initialize(user:)
          super(current_user: user)
        end

        def perform
          {
            edit: {
              code: 'edit',
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
