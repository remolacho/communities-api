class Users::ProfileSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :lastname,
             :email,
             :reference,
             :identifier,
             :phone

  attribute :avatar_url

  def avatar_url
    raise ArgumentError if enterprise_subdomain.nil?

    object.avatar_url(enterprise_subdomain)
  end

  private

  def enterprise_subdomain
    instance_options[:enterprise_subdomain]
  end
end
