# frozen_string_literal: true

class Users::ForgotPasswordService
  attr_accessor :email, :expired

  def initialize(email:, expired: nil)
    @email = email
    @expired = expired || 1.day.from_now
  end

  def call
    raise ArgumentError, I18n.t('services.users.forgot_password.email_empty') unless email.present?
    raise ActiveRecord::RecordNotFound, I18n.t('services.users.forgot_password.not_found') unless user.present?
    raise ActiveRecord::RecordNotFound, I18n.t('services.users.forgot_password.inactive') unless user.active?

    user.generate_password_token!(expired)
    UsersMailer.recover_password(user: user, enterprise: user.enterprise).deliver_now!
    user
  rescue Net::SMTPAuthenticationError => e
    raise PolicyException, I18n.t('services.users.forgot_password.send_email_error', error: e.to_s)
  end

  private

  def user
    @user ||= User.find_by(email: email)
  end
end
