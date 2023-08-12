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
class GroupRole < ApplicationRecord
  has_many :group_role_relations
  has_many :roles, through: :group_role_relations
  has_many :petitions

  scope :all_actives_petitions, -> { where(active: true, entity_type: Petition::ENTITY_TYPE ) }
end
