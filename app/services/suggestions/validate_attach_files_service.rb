# frozen_string_literal: true

class Suggestions::ValidateAttachFilesService < ::Petitions::ValidateAttachFilesService
  def initialize(data:, max_files: 2)
    super(data: data, max_files: max_files)
  end
end
