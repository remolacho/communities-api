# frozen_string_literal: true

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

FactoryBot.define do
  password = '12345678'

  factory :user do
    token { SecureRandom.uuid }
    name { FFaker::Name.first_name }
    lastname { FFaker::Name.last_name }
    identifier { "#{FFaker::IdentificationESCL.rut}-#{Random.rand(20..129)}" }
    email do
      "#{FFaker::Name.first_name}.#{Random.rand(20..30)}#{Random.rand(20..30)}#{Random.rand(20..30)}@community.com"
    end
    reference { 'T4-P11-A1102' }
    phone { '3174131149' }
    password { password }
    password_confirmation { password }
  end
end
