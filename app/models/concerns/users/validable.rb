module Users
  module Validable
    extend ActiveSupport::Concern

    PASSWORD_TOP = 6

    included do
      validates :reference,
                length: { minimum: 10, maximum: 30 }

      validates :identifier,
                presence: true,
                format: { with: /\d[0-9]\)*\z/  },
                length: { minimum: 4, maximum: 15 }

      validates :phone,
                presence: true,
                numericality: true,
                format: { with: /\d[0-9]\)*\z/  },
                length: { minimum: 8, maximum: 15 }

      validates :email,
                format: { with: /\A(.+)@(.+)\z/ },
                length: { minimum: 4, maximum: 50 }

      validates :password,
                length: { minimum: PASSWORD_TOP }, on: :create

      validates :name,
                presence: true,
                length: { minimum: 2, maximum: 30 }

      validates :lastname,
                presence: true,
                length: { minimum: 2, maximum: 30 }

      validate :validate_avatar_content_type
      validate :validate_avatar_size
    end

    def validate_avatar_content_type
      return unless avatar.attached?

      types = %w(image/jpeg image/png image/jpg)

      raise ArgumentError, I18n.t('services.users.sign_up.avatar.type') unless avatar.content_type.in?(types)
    end

    def validate_avatar_size
      return unless avatar.attached?

      raise ArgumentError, I18n.t('services.users.sign_up.avatar.size') if avatar.byte_size > 1.megabytes
    end
  end
end
