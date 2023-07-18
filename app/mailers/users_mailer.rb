class UsersMailer < ApplicationMailer
  def recover_password(user:, enterprise:)
    return unless can_send_email?

    @user = user
    @enterprise = enterprise
    @subject = I18n.t("services.users.forgot_password.subject")
    @email_to = Rails.env.production? ? @user.email : ENV['EMAIL_TO']
    mail(to: @email_to, subject: @subject)
  end
end
