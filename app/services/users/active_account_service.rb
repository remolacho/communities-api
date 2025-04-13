# frozen_string_literal: true

module Users
  class ActiveAccountService
    attr_accessor :token

    def initialize(token:)
      @token = token
    end

    def call
      raise ArgumentError, I18n.t('services.users.sign_up.account.token.empty') unless token.present?
      raise ActiveRecord::RecordNotFound, I18n.t('services.users.sign_up.account.token.not_found') unless user.present?

      user.clear_active_key!
    end

    private

    def user
      @user ||= User.find_by(active_key: token)
    end
  end
end
