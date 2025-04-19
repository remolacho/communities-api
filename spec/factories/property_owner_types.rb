# == Schema Information
#
# Table name: property_owner_types
#
#  id            :bigint           not null, primary key
#  active        :boolean          default(TRUE), not null
#  code          :string           not null
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  enterprise_id :bigint           not null
#
# Indexes
#
#  index_property_owner_types_on_code           (code) UNIQUE
#  index_property_owner_types_on_enterprise_id  (enterprise_id)
#
# Foreign Keys
#
#  fk_rails_...  (enterprise_id => enterprises.id)
#
# frozen_string_literal: true

FactoryBot.define do
  factory :property_owner_type do
    enterprise

    trait :propietario do
      code { 'propietario' }
      name { 'Propietario' }
    end

    trait :propietario_legal do
      code { 'propietario-legal' }
      name { 'Propietario Legal' }
    end

    trait :inquilino do
      code { 'inquilino' }
      name { 'Inquilino' }
    end

    trait :hipoteca do
      code { 'hipoteca' }
      name { 'Hipoteca' }
    end

    trait :leasing do
      code { 'leasing' }
      name { 'Leasing habitacional' }
    end
  end
end
