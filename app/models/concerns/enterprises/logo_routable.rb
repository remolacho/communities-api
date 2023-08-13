# frozen_string_literal: true

module Enterprises
  module LogoRoutable
    extend ActiveSupport::Concern

    def logo_url
      return unless logo.attached?

      return logo.url unless Rails.env.test?

      url_path = Rails.application.routes.url_helpers.rails_blob_path(logo, only_path: true)
      "#{ENV['BASE_HOST']}#{url_path}?enterprise_subdomain=#{enterprise.subdomain}"
    end
  end
end
