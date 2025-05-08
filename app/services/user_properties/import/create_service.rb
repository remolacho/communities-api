# frozen_string_literal: true

module UserProperties
  module Import
    class CreateService
      attr_reader :user, :file

      def initialize(user:, file:)
        @user = user
        @file = file
      end

      def call
        service_process_data.call(service_read_xlsx.call)
      end

      private

      def service_process_data
        @service_process_data ||= ProcessDataService.new(user: user)
      end

      def service_read_xlsx
        @service_read_xlsx ||= ReadXlsx.new(file: file)
      end
    end
  end
end
