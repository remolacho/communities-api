# frozen_string_literal: true

module Users
  module AvatarRoutable
    extend ActiveSupport::Concern

    def avatar_url(enterprise_subdomain)
      return unless avatar.attached?

      return avatar.url unless Rails.env.test?

      url_path = Rails.application.routes.url_helpers.rails_blob_path(avatar, only_path: true)
      "#{ENV['BASE_HOST']}#{url_path}?enterprise_subdomain=#{enterprise_subdomain}"
    end
  end
end
