# == Schema Information
#
# Table name: group_roles
#
#  id          :bigint           not null, primary key
#  active      :boolean          default(TRUE)
#  code        :string           not null
#  entity_type :string           default("petitions"), not null
#  name        :jsonb            not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_group_roles_on_code_and_entity_type  (code,entity_type) UNIQUE
#

FactoryBot.define do
  factory :group_role do
  end

  trait :all do
    code {'all'}
    name {{es: "Todas las partes"}}
  end

  trait :admin do
    code { 'admin' }
    name { {es: "Sólo Administración"}  }
  end

  trait :admin_committee do
    code { 'admincomi' }
    name { {es: "Administración y Comité"} }
  end

  trait :coexistence_committee do
    code { 'concomi' }
    name { {es: "Consejo y Comité"} }
  end

  trait :listed_suggestions do
    code { 'view_suggestions' }
    name { {es: "Pueden listar las sugerencias"} }
    entity_type { 'suggestions' }
  end

  trait :show_suggestion do
    code { 'create_suggestions' }
    name { {es: "Pueden ver las sugerencias"} }
    entity_type { 'suggestions' }
  end
end
