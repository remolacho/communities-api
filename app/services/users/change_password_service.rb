# frozen_string_literal: true

module Users
  class ChangePasswordService
    attr_accessor :token, :data

    def initialize(token:, data:)
      @token = token
      @data = data
    end

    def call
      raise ActiveRecord::RecordInvalid unless password?

      user = verifier_service.call
      user.clear_reset_password_key!(data[:password], data[:password_confirmation])
    end

    private

    def password?
      data[:password].present? && data[:password].size >= User::PASSWORD_TOP
    end

    def verifier_service
      @verifier_service ||= VerifierChangePasswordService.new(token: token)
    end
  end
end
