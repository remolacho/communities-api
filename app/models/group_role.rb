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
class GroupRole < ApplicationRecord
  has_many :group_role_relations
  has_many :roles, through: :group_role_relations
  has_many :petitions
end
