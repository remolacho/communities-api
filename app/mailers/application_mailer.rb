class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('EMAIL_FROM', nil)
  layout 'mailer'

  private

  def can_send_email?
    !Rails.env.test? || (Rails.env.test? && ENV['SEND_EMAIL'].eql?('true'))
  end

  def logo(enterprise)
    unless enterprise.logo.present?
      return attachments.inline['logo.png'] =
               File.read("#{Rails.root.join('app/assets/images/logo2.png')}")
    end

    @logo = enterprise.logo_url
  end
end
