class AnswerPetitionMailer < ApplicationMailer
  def notify(user:, enterprise:, petition:, answer:)
    return unless can_send_email?

    attachments.inline['logo2.png'] = File.read("#{Rails.root}/app/assets/images/logo2.png")

    @user = user
    @enterprise = enterprise
    @petition = petition
    @answer = answer
    @subject = I18n.t("services.answers_petitions.mail.nofify.subject")
    @email_to = Rails.env.production? ? @user.email : ENV['EMAIL_TO']
    mail(to: @email_to, subject: @subject)
  end
end
