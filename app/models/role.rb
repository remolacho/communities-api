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
class Role < ApplicationRecord
  has_many :user_roles
  has_many :users, through: :user_roles
  has_many :group_role_relations
  has_many :group_roles, through: :group_role_relations
  has_many :petitions, through: :group_roles
end
