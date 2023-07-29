class User
  module Validable
    extend ActiveSupport::Concern

    included do
      validates :address,
                presence: true,
                length: { minimum: 10, maximum: 30 }

      validates :phone,
                presence: true,
                numericality: true,
                format: { with: /\d[0-9]\)*\z/  },
                length: { minimum: 8, maximum: 15 }

      validates :email,
                format: { with: /\A(.+)@(.+)\z/ },
                length: { minimum: 4, maximum: 50 }

      validates :password,
                length: { minimum: 6 }, on: :create

      validates :name,
                presence: true,
                length: { minimum: 2, maximum: 30 }

      validates :lastname,
                presence: true,
                length: { minimum: 2, maximum: 30 }

      validates :identifier,
                presence: true,
                length: { minimum: 4, maximum: 15 }
    end
  end
end
