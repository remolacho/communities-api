# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  code       :string           not null
#  name       :jsonb            not null
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_roles_on_code  (code) UNIQUE
#  index_roles_on_slug  (slug) UNIQUE
#
FactoryBot.define do
  factory :role do
  end

  trait :owner do
    code { 'owner' }
    name { "Owner" }
    slug { "Owner".parameterize }
  end

  trait :coexistence_member do
    code { 'convi' }
    name { "Coexistence Member" }
    slug { "Coexistence Member".parameterize }
  end

  trait :committee_member do
    code { 'comite' }
    name { "Committee Member" }
    slug { "Committee Member".parameterize }
  end
end
