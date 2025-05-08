# frozen_string_literal: true

module Suggestions
  module List
    class Policy < BasePolicy
      def can_read!
        loudly do
          role?(:can_read)
        end
      end

      private

      # override
      def entity
        @entity ||= Suggestion.name
      end
    end
  end
end
