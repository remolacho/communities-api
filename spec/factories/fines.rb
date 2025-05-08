# frozen_string_literal: true

# == Schema Information
#
# Table name: fines
#
#  id               :bigint           not null, primary key
#  fine_type        :string           not null
#  message          :string           not null
#  ticket           :string           not null
#  title            :string           not null
#  token            :string           not null
#  value            :float            default(0.0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  category_fine_id :bigint           not null
#  property_id      :bigint           not null
#  status_id        :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_fines_on_category_fine_id  (category_fine_id)
#  index_fines_on_property_id       (property_id)
#  index_fines_on_status_id         (status_id)
#  index_fines_on_ticket            (ticket) UNIQUE
#  index_fines_on_token             (token) UNIQUE
#  index_fines_on_user_id           (user_id)
#
FactoryBot.define do
  factory :fine do
    token { SecureRandom.uuid }
    title { "Fine #{FFaker::Lorem.word}" }
    message { FFaker::Lorem.sentence }
    ticket { "TK-#{SecureRandom.hex(4).upcase}" }
    fine_type { Fines::Type::FINE_LEGAL }

    association :user
    association :property
    association :category_fine
    association :status

    trait :legal do
      fine_type { Fines::Type::FINE_LEGAL }
    end

    trait :warning do
      fine_type { Fines::Type::FINE_WARNING }
    end
  end
end
