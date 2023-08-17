# frozen_string_literal: true

module Suggestions
  module FileRoutable
    extend ActiveSupport::Concern

    def file_url(file, enterprise_subdomain)
      return file.url unless Rails.env.test?

      url_path = Rails.application.routes.url_helpers.rails_blob_path(file, only_path: true)
      "#{ENV['BASE_HOST']}#{url_path}?enterprise_subdomain=#{enterprise_subdomain}"
    end
  end
end
