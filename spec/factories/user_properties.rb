# == Schema Information
#
# Table name: user_properties
#
#  id                  :bigint           not null, primary key
#  observation         :string           not null
#  property_attributes :jsonb            not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  property_id         :bigint
#  status_id           :bigint
#  user_id             :bigint
#
# Indexes
#
#  index_user_properties_on_property_id  (property_id)
#  index_user_properties_on_status_id    (status_id)
#  index_user_properties_on_user_id      (user_id)
#
FactoryBot.define do
  factory :user_property do
  end
end
