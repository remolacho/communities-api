# frozen_string_literal: true

module Petitions
  module FileRoutable
    extend ActiveSupport::Concern

    def file_url(file, enterprise_subdomain)
      return file.url unless Rails.env.test? || ENV['LOCAL_STORAGE'].eql?('local')

      url_path = Rails.application.routes.url_helpers.rails_blob_path(file, only_path: true)
      "#{ENV.fetch('BASE_HOST', nil)}#{url_path}?enterprise_subdomain=#{enterprise_subdomain}"
    end
  end
end
