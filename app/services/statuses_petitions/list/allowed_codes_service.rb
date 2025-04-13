# frozen_string_literal: true

module StatusesPetitions
  module List
    class AllowedCodesService < FacadeService
      def code
        generate_codes
      end

      def exists?(code)
        generate_codes.include?(code)
      end

      private

      def generate_codes
        @generate_codes ||= factory.call.map { |s| s[:code] }
      end
    end
  end
end
