class Users::ListSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :lastname,
             :email,
             :address,
             :identifier,
             :phone

  attribute :avatar_url
  attribute :active

  def avatar_url
    raise ArgumentError if enterprise_subdomain.nil?

    object.avatar_url(enterprise_subdomain)
  end

  def active
    object.user_enterprise.active
  end

  private

  def enterprise_subdomain
    instance_options[:enterprise_subdomain]
  end
end
