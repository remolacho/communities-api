# frozen_string_literal: true

module UpdateStatusFines
  class Policy < BasePolicy
    attr_accessor :fine, :status

    def initialize(current_user:, fine:, status:)
      super(current_user: current_user)

      @fine = fine
      @status = status
    end

    def can_write!
      loudly do
        statuses.exists?(status.code)
      end
    end

    private

    def statuses
      ::Fines::Statuses::AllowedCodesService.new(user: current_user, fine: fine)
    end
  end
end
