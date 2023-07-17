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
  belongs_to :user_role, optional: true
  has_many :users, through: :user_role
  belongs_to :group_petition_role, optional: true
  has_many :group_petitions, through: :group_petition_role
end
