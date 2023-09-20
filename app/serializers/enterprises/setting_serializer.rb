class Enterprises::SettingSerializer < ActiveModel::Serializer
  attributes :token,
             :subdomain,
             :name

  attribute :logo_url
  attribute :banner_url
  attribute :menu

  def logo_url
    raise ArgumentError if object.subdomain.nil?

    object.logo_url
  end

  def banner_url
    raise ArgumentError if object.subdomain.nil?

    object.banner_url
  end

  def menu
    instance_options[:menu].build
  end
end
