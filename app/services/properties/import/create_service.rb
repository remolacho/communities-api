# frozen_string_literal: true

module Properties
  module Import
    class CreateService
      def initialize(file:)
        @file = file
      end

      def call
        # TODO: Implement property import logic
      end

      private

      attr_reader :file
    end
  end
end
