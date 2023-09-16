# frozen_string_literal: true

module Enterprises
  module BannerRoutable
    extend ActiveSupport::Concern

    def banner_url
      return unless banner.attached?

      return banner.url unless Rails.env.test? || ENV['LOCAL_STORAGE'].eql?('local')

      url_path = Rails.application.routes.url_helpers.rails_blob_path(banner, only_path: true)
      "#{ENV['BASE_HOST']}#{url_path}?enterprise_subdomain=#{subdomain}"
    end
  end
end
