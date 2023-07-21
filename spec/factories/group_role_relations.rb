# == Schema Information
#
# Table name: group_role_petitions
#
#  id            :bigint           not null, primary key
#  active        :boolean          default(TRUE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  group_role_id :bigint           not null
#  role_id       :bigint           not null
#
# Indexes
#
#  index_group_role_petitions_on_group_role_id              (group_role_id)
#  index_group_role_petitions_on_group_role_id_and_role_id  (group_role_id,role_id) UNIQUE
#  index_group_role_petitions_on_role_id                    (role_id)

FactoryBot.define do
  factory :group_role_relation do
    role_id { role.id }
    group_role_id  { group_role.id }
  end
end
