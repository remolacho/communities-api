# frozen_string_literal: true

module Fines
  class UpdateStatusService
    attr_accessor :user, :fine, :status

    def initialize(user:, fine:, status:)
      @user = user
      @status = status
      @fine = fine
    end

    def call
      fine.status = status
      fine.save!
    end
  end
end
