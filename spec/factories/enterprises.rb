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

FactoryBot.define do
  factory :enterprise do
    token { SecureRandom.uuid }
    name { 'Test community 1' }
    social_reason { 'Test community 1' }
    identifier { "#{FFaker::IdentificationESCL.rut}-#{Random.rand(20..129)}" }
    subdomain { 'public' }
    short_name { 'test'.upcase }
    email do
      "#{FFaker::Name.first_name}.#{Random.rand(20..30)}#{Random.rand(20..30)}#{Random.rand(20..30)}@community.com"
    end
    reference_regex do
      '^T[0-4]-P(1[0-6]|[1-9])-A((10[1-8])|(20[1-8])|(30[1-8])|(40[1-8])|(50[1-8])|(60[1-8])|(70[1-8])|(80[1-8])|(90[1-8])|(100[1-8])|(110[1-8])|(120[1-8])|(130[1-8])|(140[1-8])|(150[1-8])|(160[1-8]))$'
    end
  end
end
