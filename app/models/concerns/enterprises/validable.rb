module Enterprises
  module Validable
    extend ActiveSupport::Concern

    PASSWORD_TOP = 6

    included do
      validates :rut,
                presence: true,
                length: { minimum: 10, maximum: 30 }

      validates :email,
                presence: true,
                format: { with: /\A(.+)@(.+)\z/ },
                length: { minimum: 4, maximum: 50 }

      validates :name,
                presence: true,
                length: { minimum: 2, maximum: 30 }

      validates :short_name,
                presence: true,
                length: { minimum: 3, maximum: 6 }

      validate :validate_avatar_content_type
      validate :validate_avatar_size
    end

    def validate_avatar_content_type
      return unless logo.attached?

      types = %w(image/jpeg image/png image/jpg)

      raise ArgumentError, I18n.t('services.enterprises.sign_up.avatar.type') unless logo.content_type.in?(types)
    end

    def validate_avatar_size
      return unless logo.attached?

      raise ArgumentError, I18n.t('services.enterprises.sign_up.avatar.size') if logo.byte_size > 1.megabytes
    end
  end
end
