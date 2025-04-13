# frozen_string_literal: true

class Suggestions::ValidateAttachFilesService < Petitions::ValidateAttachFilesService
  def initialize(data:, max_files: 2)
    super
  end
end
