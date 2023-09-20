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

  trait :super_admin do
    code { 'super_admin' }
    name {"Super admin" }
    slug {"Super admin".parameterize }
  end

  trait :role_admin do
    code { 'admin' }
    name {"admin" }
    slug {"admin".parameterize }
  end

  trait :manager do
    code { 'manager' }
    name {"President/Manager" }
    slug {"President/Manager".parameterize }
  end

  trait :owner do
    code { 'owner' }
    name { "Owner" }
    slug { "Owner".parameterize }
  end

  trait :owner_admin do
    code { 'owner_admin' }
    name { "Owner admin" }
    slug { "Owner admin".parameterize }
  end

  trait :coexistence_member do
    code { 'coexistence' }
    name { "Coexistence Member" }
    slug { "Coexistence Member".parameterize }
  end

  trait :council_member do
    code { 'council' }
    name { "Committee Member" }
    slug { "Committee Member".parameterize }
  end
end
