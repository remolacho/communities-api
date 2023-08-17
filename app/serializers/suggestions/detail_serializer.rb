class Suggestions::DetailSerializer < ActiveModel::Serializer
  attributes :id,
             :token,
             :message,
             :ticket,
             :readed,
             :anonymous

  attribute :user

  def user
    return ::Users::AnonymousProfileSerializer.new(object.user) if object.anonymous

    ::Users::BasicProfileSerializer.new(object.user,
                                        enterprise_subdomain: enterprise_subdomain)
  end

  private

  def enterprise_subdomain
    instance_options[:enterprise_subdomain]
  end
end
