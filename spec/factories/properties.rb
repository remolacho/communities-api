# == Schema Information
#
# Table name: properties
#
#  id         :bigint           not null, primary key
#  name       :jsonb            not null
#  token      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_properties_on_token  (token) UNIQUE
#
FactoryBot.define do
  factory :property do
    
  end
end
