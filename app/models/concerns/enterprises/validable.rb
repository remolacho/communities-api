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

      validate :validate_logo_content_type
      validate :validate_logo_size
      validate :validate_banner_content_type
      validate :validate_banner_size
    end

    def validate_logo_content_type
      return unless logo.attached?

      types = ['image/jpeg', 'image/png', 'image/jpeg']

      raise ArgumentError, I18n.t('services.enterprises.sign_up.image.type') unless logo.content_type.in?(types)
    end

    def validate_logo_size
      return unless logo.attached?

      raise ArgumentError, I18n.t('services.enterprises.sign_up.image.size') if logo.byte_size > 5.megabytes
    end

    def validate_banner_content_type
      return unless banner.attached?

      types = ['image/jpeg', 'image/png', 'image/jpeg']

      raise ArgumentError, I18n.t('services.enterprises.sign_up.image.type') unless banner.content_type.in?(types)
    end

    def validate_banner_size
      return unless banner.attached?

      raise ArgumentError, I18n.t('services.enterprises.sign_up.image.size') if banner.byte_size > 5.megabytes
    end
  end
end
