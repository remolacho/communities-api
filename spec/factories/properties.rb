# == Schema Information
#
# Table name: properties
#
#  id         :bigint           not null, primary key
#  created_by :integer          not null
#  name       :jsonb            not null
#  token      :string           not null
#  updated_by :integer          not null
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
