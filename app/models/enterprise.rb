# frozen_string_literal: true

# == Schema Information
#
# Table name: enterprises
#
#  id                    :bigint           not null, primary key
#  active                :boolean          default(TRUE)
#  address               :string
#  document_type         :string           default("NIT"), not null
#  email                 :string           not null
#  identifier            :string           not null
#  name                  :string           not null
#  placeholder_reference :string           default("T4-P11-A1102"), not null
#  reference_regex       :string
#  short_name            :string           not null
#  social_reason         :string           not null
#  subdomain             :string           not null
#  token                 :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
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
  include ::Enterprises::BannerRoutable

  has_many :category_petitions, dependent: :destroy
  has_many :user_enterprises, dependent: :destroy
  has_many :users, through: :user_enterprises
  has_many :category_fines, dependent: :destroy
  has_many :property_types, dependent: :restrict_with_error
  has_many :property_owner_types, dependent: :restrict_with_error
  has_many :properties, dependent: :restrict_with_error

  has_one_attached :logo, dependent: :purge
  has_one_attached :banner, dependent: :purge
end
