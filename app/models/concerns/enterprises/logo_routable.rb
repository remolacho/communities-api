# frozen_string_literal: true

module Enterprises
  module LogoRoutable
    extend ActiveSupport::Concern

    def logo_url
      return unless logo.attached?
      return logo.url(expires_in: 2.hours) unless Rails.env.test? || ENV['LOCAL_STORAGE'].eql?('local')

      url_path = Rails.application.routes.url_helpers.rails_blob_path(logo, only_path: true)
      "#{ENV.fetch('BASE_HOST', nil)}#{url_path}?enterprise_subdomain=#{subdomain}"
    end
  end
end
