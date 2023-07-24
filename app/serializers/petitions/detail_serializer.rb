class Petitions::DetailSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :token,
             :message,
             :ticket

  attribute :status
  attribute :category
  attribute :group_role

  def status
    ActiveModelSerializers::SerializableResource.new(object.status,
                                                     serializer: ::Statuses::DetailSerializer )
  end

  def category
    ActiveModelSerializers::SerializableResource.new(object.category_petition,
                                                     serializer: ::CategoryPetitions::DetailSerializer )
  end


  def group_role
    ActiveModelSerializers::SerializableResource.new(object.group_role,
                                                     serializer: ::GroupRoles::DetailSerializer )
  end
end
