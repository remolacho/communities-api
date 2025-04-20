# frozen_string_literal: true

module Users
  module Profile
    class Policy < BasePolicy
      attr_accessor :profile

      def initialize(current_user:, profile:)
        super(current_user: current_user)

        @profile = profile
      end

      def can_read!
        loudly do
          owner? || role?(:can_read)
        end
      end

      private

      # override
      def entity
        @entity ||= User.name
      end

      def owner?
        current_user.id == profile.id
      end
    end
  end
end
