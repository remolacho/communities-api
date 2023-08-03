# frozen_string_literal: true

module AnswersPetitions
  module FileRoutable
    extend ActiveSupport::Concern

    def file_url(file, enterprise_subdomain)
      return if Rails.env.production?

      file_dev_url(file, enterprise_subdomain)
    end

    private
    def file_dev_url(file, enterprise_subdomain)
      url_path = Rails.application.routes.url_helpers.rails_blob_path(file, only_path: true)
      "#{ENV['BASE_HOST']}#{url_path}?enterprise_subdomain=#{enterprise_subdomain}"
    end
  end
end
