class Enterprises::SettingSerializer < ActiveModel::Serializer
  attributes :id,
             :token,
             :name,
             :rut,
             :address,
             :email,
             :subdomain

  attribute :logo_url
  attribute :banner_url

  def logo_url
    raise ArgumentError if object.subdomain.nil?

    object.logo_url
  end

  def banner_url
    raise ArgumentError if object.subdomain.nil?

    object.banner_url
  end
end
