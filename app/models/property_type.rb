# == Schema Information
#
# Table name: property_types
#
#  id             :bigint           not null, primary key
#  active         :boolean          default(TRUE), not null
#  code           :string           not null
#  location_regex :string           not null
#  name           :string           not null
#  placeholder    :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  enterprise_id  :bigint           not null
#
# Indexes
#
#  index_property_types_on_code           (code) UNIQUE
#  index_property_types_on_enterprise_id  (enterprise_id)
#
# Foreign Keys
#
#  fk_rails_...  (enterprise_id => enterprises.id)
#
class PropertyType < ApplicationRecord
  # Relationships
  belongs_to :enterprise
  has_many :properties, dependent: :restrict_with_error

  # Validations
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :location_regex, presence: true
  validates :placeholder, presence: true
  validates :active, inclusion: { in: [true, false] }

  # Scopes
  scope :active, -> { where(active: true) }
end
