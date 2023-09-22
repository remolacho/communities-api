class ApplicationMailer < ActionMailer::Base
  default from: ENV['EMAIL_FROM']
  layout 'mailer'

  private

  def can_send_email?
    !Rails.env.test? || (Rails.env.test? && ENV['SEND_EMAIL'].eql?('true'))
  end

  def logo(enterprise)
    return attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo2.png") unless enterprise.logo.present?

    @logo = enterprise.logo_url
  end
end
