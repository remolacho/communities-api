# == Schema Information
#
# Table name: users
#
#  id                            :bigint           not null, primary key
#  address                       :string
#  email                         :string           not null
#  identifier                    :string           not null
#  lang                          :string           default("es"), not null
#  lastname                      :string           not null
#  name                          :string           not null
#  password_digest               :string           not null
#  phone                         :string
#  reset_password_key            :string
#  reset_password_key_expires_at :datetime
#  token                         :string           not null
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#
# Indexes
#
#  index_users_on_email               (email) UNIQUE
#  index_users_on_identifier          (identifier) UNIQUE
#  index_users_on_reset_password_key  (reset_password_key) UNIQUE
#  index_users_on_token               (token) UNIQUE
#
class User < ApplicationRecord
  has_secure_password

  has_one :user_enterprise
  has_one :enterprise, through: :user_enterprise
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :petitions
  has_many :answers_petitions
  has_many :follow_petitions

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

  def generate_password_token!(expired)
    begin
      self.reset_password_key = SecureRandom.uuid
    end while User.exists?(reset_password_key: reset_password_key)

    self.reset_password_key_expires_at = expired
    save!
  end

  def clear_reset_password_key!(password, p_confirmation)
    self.password = password
    self.password_confirmation = p_confirmation
    self.reset_password_key = nil
    self.reset_password_key_expires_at = nil
    save!
  end
end
