class AnswersPetitions::DetailSerializer < ActiveModel::Serializer
  attributes :id, :message
  attribute :date_at
  attribute :user

  def user
    ActiveModelSerializers::SerializableResource.new(object.user,
                                                     serializer: ::Users::BasicProfileSerializer )
  end
  def date_at
    object.created_at
  end
end
