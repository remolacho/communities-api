# == Schema Information
#
# Table name: user_properties
#
#  id                     :bigint           not null, primary key
#  active                 :boolean          default(TRUE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  property_id            :bigint           not null
#  property_owner_type_id :bigint           not null
#  user_id                :bigint           not null
#
# Indexes
#
#  index_user_properties_on_property_id              (property_id)
#  index_user_properties_on_property_owner_type_id   (property_owner_type_id)
#  index_user_properties_on_user_id                  (user_id)
#  index_user_properties_on_user_id_and_property_id  (user_id,property_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (property_id => properties.id)
#  fk_rails_...  (property_owner_type_id => property_owner_types.id)
#  fk_rails_...  (user_id => users.id)
#
class UserProperty < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :property
  belongs_to :property_owner_type

  # Validations
  validates :active, inclusion: { in: [true, false] }

  # Scopes
  scope :active, -> { where(active: true) }
end
