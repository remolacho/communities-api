class Users::AnonymousProfileSerializer < ActiveModel::Serializer
  attribute :id
  attribute :name
  attribute :lastname
  attribute :avatar_url

  def id
    nil
  end

  def name
    I18n.t('services.users.anonymous.name')
  end

  def lastname
    I18n.t('services.users.anonymous.lastname')
  end

  def avatar_url
    nil
  end

  private

  def enterprise_subdomain
    instance_options[:enterprise_subdomain]
  end
end
