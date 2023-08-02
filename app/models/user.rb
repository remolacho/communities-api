# == Schema Information
#
# Table name: users
#
#  id                            :bigint           not null, primary key
#  active_key                    :string
#  active_key_expires_at         :datetime
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
#  index_users_on_active_key          (active_key) UNIQUE
#  index_users_on_email               (email) UNIQUE
#  index_users_on_identifier          (identifier) UNIQUE
#  index_users_on_reset_password_key  (reset_password_key) UNIQUE
#  index_users_on_token               (token) UNIQUE
#
class User < ApplicationRecord
  include ::Users::Validable
  include ::Users::Tokenizable
  include ::Users::Cleanable
  include ::Users::Ransackable
  include ::Users::AvatarRoutable

  has_secure_password

  has_one :user_enterprise
  has_one :enterprise, through: :user_enterprise
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :petitions
  has_many :answers_petitions
  has_many :follow_petitions

  has_one_attached :avatar, dependent: :purge

  def active?
    user_enterprise.active
  end
end
