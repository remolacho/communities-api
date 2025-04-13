# frozen_string_literal: true

module AnswersPetitions
  module Files
    class ListService
      attr_accessor :user, :answer, :enterprise

      def initialize(enterprise:, user:, answer:)
        @enterprise = enterprise
        @user = user
        @answer = answer
      end

      def call
        answer.files.map do |file|
          {
            name: file.filename.to_s,
            ext: File.extname(file.filename.to_s),
            url: answer.file_url(file, enterprise.subdomain)
          }
        end
      end
    end
  end
end
