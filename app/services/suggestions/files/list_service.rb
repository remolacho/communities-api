# frozen_string_literal: true

module Suggestions
  module Files
    class ListService
      attr_accessor :user, :suggestion, :enterprise

      def initialize(enterprise:, user:, suggestion:)
        @enterprise = enterprise
        @user = user
        @suggestion = suggestion
      end

      def call
        suggestion.files.map do |file|
          {
            name: file.filename.to_s,
            ext: File.extname(file.filename.to_s),
            url: suggestion.file_url(file, enterprise.subdomain)
          }
        end
      end
    end
  end
end
