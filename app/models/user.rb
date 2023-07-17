# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  identifier      :string           not null
#  lang            :string           default("es"), not null
#  lastname        :string           not null
#  name            :string           not null
#  password_digest :string           not null
#  token           :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email       (email) UNIQUE
#  index_users_on_identifier  (identifier) UNIQUE
#  index_users_on_token       (token) UNIQUE
#
class User < ApplicationRecord
  has_secure_password

  belongs_to :user_enterprise, optional: true
  has_many :enterprises, through: :user_enterprise
  belongs_to :user_role, optional: true
  has_many :roles, through: :user_role
end
