# frozen_string_literal: true

module Enterprises
  module Update
    class Policy < BasePolicy
      def can_write!
        loudly do
          role?(:can_write)
        end
      end

      def can_read!
        loudly do
          role?(:can_read)
        end
      end

      private

      # override
      def entity
        @entity ||= Enterprise.name
      end
    end
  end
end
