# frozen_string_literal: true

class Users::ForgotPasswordService
  attr_accessor :email

  def initialize(email:)
    @email = email
  end

  def call
    raise ArgumentError, I18n.t('services.users.forgot_password.email_empty') unless email.present?
    raise ActiveRecord::RecordNotFound, I18n.t('services.users.forgot_password.not_found') unless user.present?
    raise ActiveRecord::RecordNotFound, I18n.t("services.users.forgot_password.inactive") unless active?

    user.generate_password_token!(1.day.from_now)
    UsersMailer.recover_password(user: user, enterprise: user.enterprise).deliver_now!
    user
  rescue Net::SMTPAuthenticationError => e
    raise PolicyException, I18n.t('services.users.forgot_password.send_email_error', error: e.to_s)
  end

  private

  def active?
    user.user_enterprise.active
  end

  def user
    @user ||= User.find_by(email: email)
  end
end
