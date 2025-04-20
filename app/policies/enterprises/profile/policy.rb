# frozen_string_literal: true

module Enterprises
  module Profile
    class Policy < BasePolicy
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
