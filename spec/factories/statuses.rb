# == Schema Information
#
# Table name: statuses
#
#  id          :bigint           not null, primary key
#  code        :string           not null
#  name        :jsonb            not null
#  status_type :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_statuses_on_code  (code) UNIQUE
#
FactoryBot.define do
  factory :status do
  end

  trait :petition_pending do
    name {{es: "Pendiente", en: "Pending"}}
    code {"pet-pending"}
    status_type {'petition'}
  end
end
