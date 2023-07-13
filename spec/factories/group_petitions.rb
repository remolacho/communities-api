# == Schema Information
#
# Table name: group_petitions
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE)
#  code       :string           not null
#  name       :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_group_petitions_on_code  (code) UNIQUE
#
FactoryBot.define do
  factory :group_petition do
    
  end
end
