# frozen_string_literal: true

module Users
  class ProfileSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :lastname,
               :email,
               :reference,
               :identifier,
               :phone,
               :token

    attribute :avatar_url
    attribute :setting

    def avatar_url
      raise ArgumentError if enterprise_subdomain.nil?

      object.avatar_url(enterprise_subdomain)
    end

    def setting
      {
        can_edit: object.id == current_user.id
      }
    end

    private

    def enterprise_subdomain
      instance_options[:enterprise_subdomain]
    end

    def current_user
      instance_options[:current_user]
    end
  end
end
