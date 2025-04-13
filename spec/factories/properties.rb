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
FactoryBot.define do
  factory :property do
  end
end
