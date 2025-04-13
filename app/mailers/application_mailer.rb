# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('EMAIL_FROM', nil)
  layout 'mailer'

  private

  def can_send_email?
    !Rails.env.test? || (Rails.env.test? && ENV['SEND_EMAIL'].eql?('true'))
  end

  def logo(enterprise)
    if enterprise.logo.blank?
      return attachments.inline['logo.png'] =
               File.read(Rails.root.join('app/assets/images/logo2.png').to_s)
    end

    @logo = enterprise.logo_url
  end
end
