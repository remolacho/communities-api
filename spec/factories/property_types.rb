# == Schema Information
#
# Table name: property_types
#
#  id             :bigint           not null, primary key
#  active         :boolean          default(TRUE), not null
#  code           :string           not null
#  location_regex :string           not null
#  name           :string           not null
#  placeholder    :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  enterprise_id  :bigint           not null
#
# Indexes
#
#  index_property_types_on_code           (code) UNIQUE
#  index_property_types_on_enterprise_id  (enterprise_id)
#
# Foreign Keys
#
#  fk_rails_...  (enterprise_id => enterprises.id)
#
# frozen_string_literal: true

FactoryBot.define do
  factory :property_type do
    enterprise
    name { "Property Type" }
    active { true }
    code { "GEN" }
    location_regex { "^[A-Z0-9-]+$" }
    placeholder { "Location format" }

    trait :apartamento do
      name { 'Apartamento' }
      code { 'apartamento' }
      location_regex { '^T[1-4]-P(1[0-6]|[1-9])-A((10[1-8])|(20[1-8])|(30[1-8])|(40[1-8])|(50[1-8])|(60[1-8])|(70[1-8])|(80[1-8])|(90[1-8])|(100[1-8])|(110[1-8])|(120[1-8])|(130[1-8])|(140[1-8])|(150[1-8])|(160[1-8]))$' }
      placeholder { 'T1-P1-A101' }
    end

    trait :local_comercial do
      name { 'Local Comercial' }
      code { 'local' }
      location_regex { '^TE-L([1-9]|[1-9][0-9]|[1-9][0-9][0-9]|1000)$' }
      placeholder { 'TE-L1' }
    end

    trait :parqueadero do
      name { 'Parqueadero' }
      code { 'parqueadero' }
      location_regex { '^TE-P([1-9]|10)-E([1-9]|[1-9][0-9]|100)$' }
      placeholder { 'TE-P1-E1' }
    end

    trait :parqueadero_visitante do
      name { 'Parqueadero visitante' }
      code { 'parqueadero-v' }
      location_regex { '^TE-P([1-9]|10)-E([1-9]|[1-9][0-9]|100)$' }
      placeholder { 'TE-P1-E5' }
    end

    trait :deposito do
      name { 'Depósito' }
      code { 'deposito' }
      location_regex { '^TE-P([1-9]|10)-D([1-9]|[1-9][0-9]|100)$' }
      placeholder { 'TE-P1-D1' }
    end

    trait :bicicletero do
      name { 'Bicicletero' }
      code { 'bicicletero' }
      location_regex { '^TE-P([1-9]|10)-B([1-9]|[1-9][0-9]|100)$' }
      placeholder { 'TE-P1-B1' }
    end

    trait :parqueadero_discapacitado do
      name { 'Parqueadero discapacitado' }
      code { 'parqueadero-d' }
      location_regex { '^TE-P([1-9]|10)-E([1-9]|[1-9][0-9]|100)$' }
      placeholder { 'TE-P1-E7' }
    end
  end
end
