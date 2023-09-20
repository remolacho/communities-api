class Petitions::DetailSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :token,
             :message,
             :ticket,
             :updated_at,
             :created_at

  attribute :status
  attribute :category
  attribute :group_role
  attribute :user
  attribute :setting

  def status
    ActiveModelSerializers::SerializableResource.new(object.status,
                                                     serializer: ::Statuses::DetailSerializer )
  end

  def category
    ActiveModelSerializers::SerializableResource.new(object.category_petition,
                                                     serializer: ::CategoryPetitions::DetailSerializer )
  end

  def user
    ::Users::BasicProfileSerializer.new(object.user,
                                        enterprise_subdomain: enterprise_subdomain)
  end

  def group_role
    ActiveModelSerializers::SerializableResource.new(object.group_role,
                                                     serializer: ::GroupRoles::DetailSerializer )
  end

  def setting
    {
      reply: {
        description: "Only reply if is different to resolve",
        action: !object.status.code.eql?(Status::PETITION_RESOLVE)
      }
    }
  end

  private

  def enterprise_subdomain
    instance_options[:enterprise_subdomain]
  end
end
