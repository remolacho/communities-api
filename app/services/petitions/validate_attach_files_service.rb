# frozen_string_literal: true

class Petitions::ValidateAttachFilesService
  attr_accessor :files, :max_files
  def initialize(data:, max_files: 2)
    @files = data[:files] || []
    @max_files = max_files
  end

  def call
    return [] unless files.present?

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
    files.each do |_, file|
      validate_avatar_content_type!(file)
      validate_avatar_size!(file)
    end
  end

  def validate_max_files!
    if files.size > max_files
      raise ArgumentError, I18n.t('services.petitions.create.files.max', max: max_files)
    end
  end

  def validate_avatar_content_type!(file)
    raise ArgumentError, I18n.t(I18n.t('services.petitions.create.files.type')) unless types.include?(extension(file))
  end

  def validate_avatar_size!(file)
    raise ArgumentError, I18n.t('services.petitions.create.files.size') if file.size  > 5.megabytes
  end

  def types
    @types ||= %w(jpeg jpg png xlsx doc docx xls pdf)
  end

  def extension(file)
    file.original_filename.split('.').last
  end
end
