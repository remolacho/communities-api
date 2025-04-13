# frozen_string_literal: true

module Suggestions
  class ValidateAttachFilesService < Petitions::ValidateAttachFilesService
    def initialize(data:, max_files: 2)
      super
    end
  end
end
