class AnswerPetitionMailer < ApplicationMailer
  def notify(user:, enterprise:, petition:)
    return unless can_send_email?

    @user = user
    @enterprise = enterprise
    @petition = petition
    @subject = I18n.t("services.answers_petitions.mail.nofify.subject")
    @email_to = Rails.env.production? ? @user.email : ENV['EMAIL_TO']
    mail(to: @email_to, subject: @subject)
  end
end
