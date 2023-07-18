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
#  phone           :string
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

FactoryBot.define do
  password = '12345678'

  factory :user do
    token { SecureRandom.uuid }
    name { FFaker::Name.first_name }
    lastname { FFaker::Name.last_name }
    identifier { "#{FFaker::IdentificationESCL.rut}-#{20 + Random.rand(110)}" }
    email { "#{FFaker::Name.first_name}.#{20 + Random.rand(11)}#{20 + Random.rand(11)}#{20 + Random.rand(11)}@community.com" }
    password { password }
    password_confirmation { password }
  end
end
