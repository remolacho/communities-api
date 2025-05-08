# frozen_string_literal: true

module Fines
  module Statuses
    class Factory
      attr_accessor :user, :fine

      def initialize(user:, fine:)
        @user = user
        @fine = fine
      end

      def call
        return legal_statuses if fine.fine_legal?
        return warning_statuses if fine.fine_warning?

        raise NotImplementedError
      end

      private

      def legal_statuses
        ::Fines::Statuses::Legal::FacadeService.new(user: user, fine: fine)
      end

      def warning_statuses
        ::Fines::Statuses::Warning::FacadeService.new(user: user, fine: fine)
      end
    end
  end
end
