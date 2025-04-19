# == Schema Information
#
# Table name: users
#
#  id                            :bigint           not null, primary key
#  active_key                    :string
#  active_key_expires_at         :datetime
#  document_type                 :string           default("CC"), not null
#  email                         :string           not null
#  identifier                    :string           not null
#  lang                          :string           default("es"), not null
#  lastname                      :string           not null
#  name                          :string           not null
#  password_digest               :string           not null
#  phone                         :string
#  reference                     :string
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
#  index_users_on_reference           (reference)
#  index_users_on_reset_password_key  (reset_password_key) UNIQUE
#  index_users_on_token               (token) UNIQUE
#
# frozen_string_literal: true

class User < ApplicationRecord
  include ::Users::Validable
  include ::Users::Tokenizable
  include ::Users::Cleanable
  include ::Users::Ransackable
  include ::Users::AvatarRoutable

  has_secure_password

  has_one :user_enterprise, dependent: :destroy
  has_one :enterprise, through: :user_enterprise
  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :petitions, dependent: :destroy
  has_many :answers_petitions, dependent: :destroy
  has_many :follow_petitions, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :user_properties, dependent: :destroy
  has_many :properties, through: :user_properties
  has_many :property_owner_types, through: :user_properties
  has_many :user_enterprises, dependent: :destroy
  has_many :enterprises, through: :user_enterprises
  has_many :fines, dependent: :restrict_with_error

  has_one_attached :avatar, dependent: :purge

  ENTITY_TYPE = 'users'

  def active?
    user_enterprise.active
  end
end
