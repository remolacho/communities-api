# frozen_string_literal: true

module Users
  module ChangeStatus
    class Policy < BasePolicy
      attr_accessor :enterprise

      def initialize(current_user:, enterprise:)
        super(current_user: current_user)

        @enterprise = enterprise
      end

      def can_write!
        loudly do
          role?(:can_write)
        end
      end

      private

      # override
      def entity
        @entity ||= User.name
      end
    end
  end
end
