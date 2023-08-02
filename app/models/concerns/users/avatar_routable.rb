# frozen_string_literal: true

module Users
  module AvatarRoutable
    extend ActiveSupport::Concern

    def avatar_url(enterprise_subdomain)
      return if Rails.env.production?

      avatar_dev_url(enterprise_subdomain)
    end

    private
    def avatar_dev_url(enterprise_subdomain)
      return unless avatar.attached?

      url_path = Rails.application.routes.url_helpers.rails_blob_path(avatar, only_path: true)
      "#{ENV['BASE_HOST']}#{url_path}?enterprise_subdomain=#{enterprise_subdomain}"
    end
  end
end
