# == Schema Information
#
# Table name: property_owner_types
#
#  id            :bigint           not null, primary key
#  active        :boolean          default(TRUE), not null
#  code          :string           not null
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  enterprise_id :bigint           not null
#
# Indexes
#
#  index_property_owner_types_on_code           (code) UNIQUE
#  index_property_owner_types_on_enterprise_id  (enterprise_id)
#
# Foreign Keys
#
#  fk_rails_...  (enterprise_id => enterprises.id)
#
FactoryBot.define do
  factory :property_owner_type do
    
  end
end
