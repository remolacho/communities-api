# frozen_string_literal: true

class Users::VerifierChangePasswordService
  attr_accessor :token

  def initialize(token:)
    @token = token
  end

  def call
    raise ArgumentError, I18n.t('services.users.forgot_password.verifier.token.empty') unless token.present?

    unless user.present?
      raise ActiveRecord::RecordNotFound,
            I18n.t('services.users.forgot_password.verifier.token.not_found')
    end
    unless user.active?
      raise ActiveRecord::RecordNotFound,
            I18n.t('services.users.forgot_password.verifier.user.inactive')
    end

    user
  end

  private

  def user
    @user ||= User.where(reset_password_key: token)
      .where('reset_password_key_expires_at > ?', Time.current).first
  end
end
