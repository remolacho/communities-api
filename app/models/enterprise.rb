# == Schema Information
#
# Table name: enterprises
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  address    :string
#  email      :string           not null
#  name       :string           not null
#  rut        :string           not null
#  short_name :string           not null
#  subdomain  :string           not null
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_enterprises_on_email      (email) UNIQUE
#  index_enterprises_on_subdomain  (subdomain) UNIQUE
#  index_enterprises_on_token      (token) UNIQUE
#
class Enterprise < ApplicationRecord
  include ::Enterprises::Validable
  include ::Enterprises::LogoRoutable

  has_many :category_petitions
  has_many :user_enterprises
  has_many :users, through: :user_enterprises

  has_one_attached :logo, dependent: :purge
end
