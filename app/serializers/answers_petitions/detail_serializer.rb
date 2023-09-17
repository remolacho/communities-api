class AnswersPetitions::DetailSerializer < ActiveModel::Serializer
  attributes :id,
             :message,
             :updated_at,
             :created_at

  attribute :date_at
  attribute :user

  def user
    ::Users::BasicProfileSerializer.new(object.user,
                                        enterprise_subdomain: enterprise_subdomain)
  end
  def date_at
    object.created_at
  end

  private

  def enterprise_subdomain
    instance_options[:enterprise_subdomain]
  end
end
