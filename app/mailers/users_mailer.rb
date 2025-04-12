class UsersMailer < ApplicationMailer
  def recover_password(user:, enterprise:)
    return unless can_send_email?

    @user = user
    @enterprise = enterprise
    @subject = I18n.t('services.users.forgot_password.subject')
    @email_to = Rails.env.production? ? @user.email : ENV.fetch('EMAIL_TO', nil)

    logo(enterprise)

    mail(to: @email_to, subject: @subject)
  end

  def verifier_account(user:, enterprise:)
    return unless can_send_email?

    @user = user
    @enterprise = enterprise
    @subject = I18n.t('services.users.sign_up.verifier_account')
    @email_to = Rails.env.production? ? @user.email : ENV.fetch('EMAIL_TO', nil)

    logo(enterprise)

    mail(to: @email_to, subject: @subject)
  end
end
