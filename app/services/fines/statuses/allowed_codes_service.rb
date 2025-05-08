# frozen_string_literal: true

module Fines
  module Statuses
    class AllowedCodesService
      attr_accessor :user, :fine

      def initialize(user:, fine:)
        @user = user
        @fine = fine
      end

      def codes
        generate_codes
      end

      def exists?(code)
        generate_codes.include?(code)
      end

      private

      def generate_codes
        @generate_codes ||= factory.call.build.map { |s| s[:code] }
      end

      def factory
        @factory ||= ::Fines::Statuses::Factory.new(user: user, fine: fine)
      end
    end
  end
end
