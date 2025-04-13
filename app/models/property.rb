# == Schema Information
#
# Table name: properties
#
#  id               :bigint           not null, primary key
#  active           :boolean          default(TRUE), not null
#  location         :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  enterprise_id    :bigint           not null
#  property_type_id :bigint           not null
#  status_id        :bigint           not null
#
# Indexes
#
#  index_properties_on_enterprise_id     (enterprise_id)
#  index_properties_on_property_type_id  (property_type_id)
#  index_properties_on_status_id         (status_id)
#
# Foreign Keys
#
#  fk_rails_...  (enterprise_id => enterprises.id)
#  fk_rails_...  (property_type_id => property_types.id)
#  fk_rails_...  (status_id => statuses.id)
#
class Property < ApplicationRecord
  # Relationships
  belongs_to :enterprise
  belongs_to :property_type
  belongs_to :status
  has_many :user_properties, dependent: :restrict_with_error
  has_many :users, through: :user_properties

  # Validations
  validates :location, presence: true
  validates :active, inclusion: { in: [true, false] }
  validate :location_matches_property_type_regex

  # Scopes
  scope :active, -> { where(active: true) }

  private

  def location_matches_property_type_regex
    return if property_type.blank? || location.blank?

    regex = Regexp.new(property_type.location_regex)
    return if location.match?(regex)

    errors.add(:location, :invalid_format)
  end
end
