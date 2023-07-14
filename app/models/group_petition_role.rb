# == Schema Information
#
# Table name: group_petition_roles
#
#  id                :bigint           not null, primary key
#  active            :boolean          default(TRUE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  group_petition_id :bigint           not null
#  role_id           :bigint           not null
#
# Indexes
#
#  index_group_petition_roles_on_group_petition_id              (group_petition_id)
#  index_group_petition_roles_on_group_petition_id_and_role_id  (group_petition_id,role_id) UNIQUE
#  index_group_petition_roles_on_role_id                        (role_id)
#
class GroupPetitionRole < ApplicationRecord
  has_many :roles
  has_many :group_petitions
end
