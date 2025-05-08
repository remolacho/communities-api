# frozen_string_literal: true

module Petitions
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
        @entity ||= Petition.name
      end
    end
  end
end
