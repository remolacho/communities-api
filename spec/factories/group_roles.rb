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
    code { 'listed_suggestions' }
    name { {es: "Pueden listar las sugerencias"} }
    entity_type { 'suggestions' }
  end

  trait :show_suggestion do
    code { 'show_suggestion' }
    name { {es: "Pueden ver las sugerencias"} }
    entity_type { 'suggestions' }
  end

  trait :show_user do
    code { 'show_user' }
    name { {es: "Pueden ver el perfil de un usuario"} }
    entity_type { 'users' }
  end

  trait :change_status_user do
    code { 'change_status_user' }
    name { {es: "Pueden cambiar el estado de un usuario"} }
    entity_type { 'users' }
  end

  trait :listed_users do
    code { 'listed_users' }
    name { {es: "Pueden listar los usuarios del sistema"} }
    entity_type { 'users' }
  end
end
