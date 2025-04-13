# frozen_string_literal: true

module Petitions
  class ValidateAttachFilesService
    attr_accessor :files, :max_files

    def initialize(data:, max_files: 2)
      @files = data[:files] || []
      @max_files = max_files
    end

    def call
      return [] if files.blank?

      validate_max_files!
      validate_files!

      attachments
    end

    private

    def attachments
      files.map do |_, file|
        {
          io: file,
          filename: file.original_filename
        }
      end
    end

    def validate_files!
      files.each_value do |file|
        validate_file_content_type!(file)
        validate_file_size!(file)
      end
    end

    def validate_max_files!
      return unless files.size > max_files

      raise ArgumentError, I18n.t('services.suggestions.create.files.max', max: max_files)
    end

    def validate_file_content_type!(file)
      raise ArgumentError, I18n.t('services.suggestions.create.files.type') unless types.include?(extension(file))
    end

    def validate_file_size!(file)
      if videos.include?(extension(file))
        raise ArgumentError, I18n.t('services.petitions.create.files.size', mb_size: 10) if file.size > 10.megabytes

        return
      end

      raise ArgumentError, I18n.t('services.petitions.create.files.size', mb_size: 5) if file.size > 5.megabytes
    end

    def types
      @types ||= docs | videos | images | audios
    end

    def docs
      @docs ||= ['xlsx', 'doc', 'docx', 'xls', 'pdf']
    end

    def videos
      @videos ||= ['mp4']
    end

    def images
      @images ||= ['jpeg', 'jpg', 'png']
    end

    def audios
      @audios ||= ['opus']
    end

    def extension(file)
      file.original_filename.split('.').last
    end
  end
end
