# == Schema Information
#
# Table name: entity_permissions
#
#  id                 :bigint           not null, primary key
#  can_change_status  :boolean          default(FALSE)
#  can_destroy        :boolean          default(FALSE)
#  can_read           :boolean          default(FALSE)
#  can_write          :boolean          default(FALSE)
#  custom_permissions :jsonb
#  entity_type        :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  role_id            :bigint           not null
#
# Indexes
#
#  index_entity_permissions_on_role_id                  (role_id)
#  index_entity_permissions_on_role_id_and_entity_type  (role_id,entity_type) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
class EntityPermission < ApplicationRecord
  belongs_to :role

  validates :entity_type, presence: true
  validates :role_id, uniqueness: { scope: :entity_type }

  scope :for_entity_type, -> (type) { where(entity_type: type) }
  scope :for_role, -> (roles_ids) { where(role_id: roles_ids) }
end
