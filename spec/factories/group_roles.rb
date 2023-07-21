# == Schema Information
#
# Table name: group_roles
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  code       :string           not null
#  name       :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_group_roles_on_code  (code) UNIQUE
#

FactoryBot.define do
  factory :group_role do
  end

  trait :coexistence_committee do
    code { 'concomi' }
    name { {es: "Consejo y Comité"} }
  end
end
