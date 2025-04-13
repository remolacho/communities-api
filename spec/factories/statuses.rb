# frozen_string_literal: true

# == Schema Information
#
# Table name: statuses
#
#  id          :bigint           not null, primary key
#  code        :string           not null
#  color       :string           default("#E8E6E6")
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
    sequence(:name) { |n| "Status #{n}" }
    sequence(:code) { |n| "ST#{n}" }
    status_type { 'test' }
  end

  trait :petition_pending do
    name { { es: 'Pendiente', en: 'Pending' } }
    code { Statuses::Codes::PETITION_PENDING }
    status_type { Statuses::Types::PETITION }
  end

  trait :petition_reviewing do
    name { { es: 'En revisión', en: 'In review' } }
    code { Statuses::Codes::PETITION_REVIEWING }
    status_type { Statuses::Types::PETITION }
  end

  trait :petition_rejected do
    name { { es: 'Rechazada', en: 'Rejected' } }
    code { Statuses::Codes::PETITION_REJECTED }
    status_type { Statuses::Types::PETITION }
  end

  trait :petition_confirm do
    name { { es: 'Confirmar solución', en: 'Confirm solution' } }
    code { Statuses::Codes::PETITION_CONFIRM }
    status_type { Statuses::Types::PETITION }
  end

  trait :petition_rejected_solution do
    name { { es: 'Rechazo de la solución', en: 'Rejected solution' } }
    code { Statuses::Codes::PETITION_REJECTED_SOLUTION }
    status_type { Statuses::Types::PETITION }
  end

  trait :petition_resolved do
    name { { es: 'Resuelta', en: 'Resolve' } }
    code { Statuses::Codes::PETITION_RESOLVED }
    status_type { Statuses::Types::PETITION }
  end

  trait :answer_delete do
    name { { es: 'Respuesta eliminada', en: 'Answer destroy' } }
    code { Statuses::Codes::ANSWER_DELETED }
    status_type { Statuses::Types::ANSWER }
  end

  # Estatus de las propiedades
  trait :property_own do
    name { { es: 'Propio', en: 'Own' } }
    code { Statuses::Codes::PROPERTY_OWN }
    status_type { Statuses::Types::PROPERTY }
  end

  trait :property_rented do
    name { { es: 'Rentado', en: 'Rented' } }
    code { Statuses::Codes::PROPERTY_RENTED }
    status_type { Statuses::Types::PROPERTY }
  end

  trait :property_loan do
    name { { es: 'Prestado', en: 'Loan' } }
    code { Statuses::Codes::PROPERTY_LOAN }
    status_type { Statuses::Types::PROPERTY }
  end

  trait :property_empty do
    name { { es: 'Vacio', en: 'Empty' } }
    code { Statuses::Codes::PROPERTY_EMPTY }
    status_type { Statuses::Types::PROPERTY }
  end
end
