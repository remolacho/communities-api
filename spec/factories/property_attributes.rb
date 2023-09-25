# == Schema Information
#
# Table name: property_attributes
#
#  id          :bigint           not null, primary key
#  created_by  :integer          not null
#  input       :string           default("list"), not null
#  max_range   :integer          default(1)
#  min_range   :integer          default(1)
#  name        :jsonb            not null
#  name_as     :jsonb
#  prefix      :string
#  token       :string           not null
#  updated_by  :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  property_id :bigint
#
# Indexes
#
#  index_property_attributes_on_property_id  (property_id)
#  index_property_attributes_on_token        (token) UNIQUE
#
FactoryBot.define do
  factory :property_attribute do
    
  end
end
