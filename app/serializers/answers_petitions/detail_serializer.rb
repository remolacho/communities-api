class AnswersPetitions::DetailSerializer < ActiveModel::Serializer
  attributes :id,
             :message,
             :updated_at,
             :created_at

  attribute :user
  attribute :files

  def user
    ::Users::BasicProfileSerializer.new(object.user,
                                        enterprise_subdomain: enterprise_subdomain)
  end
  def date_at
    object.created_at
  end

  def files
    temps = object.files || []

    temps.map do |file|
      {
        name: file.filename.to_s,
        ext: File.extname(file.filename.to_s),
        url: object.file_url(file, enterprise_subdomain)
      }
    end
  end

  private

  def enterprise_subdomain
    instance_options[:enterprise_subdomain]
  end
end
