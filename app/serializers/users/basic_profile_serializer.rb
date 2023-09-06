class Users::BasicProfileSerializer < ActiveModel::Serializer
  attributes :id,
             :identifier,
             :name,
             :lastname

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
