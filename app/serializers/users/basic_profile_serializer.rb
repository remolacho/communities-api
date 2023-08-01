class Users::BasicProfileSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :lastname

  attribute :avatar_url

  def avatar_url
    return unless object.avatar.attached?

    enterprise_subdomain = object.enterprise.subdomain
    url_path = Rails.application.routes.url_helpers.rails_blob_path(object.avatar, only_path: true)
    "#{ENV['BASE_HOST']}#{url_path}?enterprise_subdomain=#{enterprise_subdomain}"
  end
end
