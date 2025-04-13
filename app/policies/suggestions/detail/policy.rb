# frozen_string_literal: true

module Suggestions
  module Detail
    class Policy < BasePolicy
      attr_accessor :suggestion

      def initialize(current_user:, suggestion:)
        super(current_user: current_user)

        @suggestion = suggestion
      end

      def can_read!
        loudly do
          owner? || role?(:can_read)
        end
      end

      private

      def owner?
        current_user.id == suggestion.user_id
      end

      # override
      def entity
        @entity ||= Suggestion.name
      end
    end
  end
end
