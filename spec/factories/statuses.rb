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
    name { { es: "Pendiente", en: "Pending" } }
    code { Status::PETITION_PENDING }
    status_type { Status::PETITION }
  end

  trait :petition_resolved do
    name { { es: "Resuelta", en: "Resolve" } }
    code { Status::PETITION_RESOLVE }
    status_type { Status::PETITION }
  end

  trait :answer_delete do
    name {{es: "Respuesta eliminada", en: "Answer destroy"}}
    code { Status::ANSWER_DELETE }
    status_type { Status::ANSWER }
  end
end
