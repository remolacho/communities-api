# frozen_string_literal: true

module BaseZero
  module Shared
    class StatusList
      class << self
        def all
          [
            {
              name: { es: 'Pendiente', en: 'Pending' },
              code: ::Statuses::Petition::PETITION_PENDING,
              status_type: ::Statuses::Types::PETITION,
              color: '#D6EAF3'
            },
            {
              name: { es: 'En revisión', en: 'In review' },
              code: ::Statuses::Petition::PETITION_REVIEWING,
              status_type: ::Statuses::Types::PETITION,
              color: '#7AC6EB'
            },
            {
              name: { es: 'Rechazada', en: 'Rejected' },
              code: ::Statuses::Petition::PETITION_REJECTED,
              status_type: ::Statuses::Types::PETITION,
              color: '#F0553B'
            },
            {
              name: { es: 'Confirmar solución', en: 'Confirm solution' },
              code: ::Statuses::Petition::PETITION_CONFIRM,
              status_type: ::Statuses::Types::PETITION,
              color: '#3B8FF0'
            },
            {
              name: { es: 'Resuelta', en: 'Resolve' },
              code: ::Statuses::Petition::PETITION_RESOLVED,
              status_type: ::Statuses::Types::PETITION,
              color: '#8BE939'
            },
            {
              name: { es: 'Rechazo de la solución', en: 'Rejected solution' },
              code: ::Statuses::Petition::PETITION_REJECTED_SOLUTION,
              status_type: ::Statuses::Types::PETITION,
              color: '#F6FB43'
            },
            {
              name: { es: 'Respuesta eliminada', en: 'Answer destroy' },
              code: ::Statuses::Answer::ANSWER_DELETED,
              status_type: ::Statuses::Types::ANSWER
            },
            {
              name: { es: 'Propio', en: 'Own' },
              code: ::Statuses::Property::PROPERTY_OWN,
              status_type: ::Statuses::Types::PROPERTY,
              color: '#3B8FF0'
            },
            {
              name: { es: 'Rentado', en: 'Rented' },
              code: ::Statuses::Property::PROPERTY_RENTED,
              status_type: ::Statuses::Types::PROPERTY,
              color: '#8BE939'
            },
            {
              name: { es: 'Prestamo', en: 'Loan' },
              code: ::Statuses::Property::PROPERTY_LOAN,
              status_type: ::Statuses::Types::PROPERTY,
              color: '#F6FB43'
            },
            {
              name: { es: 'Vacio', en: 'Empty' },
              code: ::Statuses::Property::PROPERTY_EMPTY,
              status_type: ::Statuses::Types::PROPERTY,
              color: '#FF9800'
            },
            {
              name: { es: 'Asignada', en: 'Assigned' },
              code: ::Statuses::FineLegal::FINE_LEGAL_ASSIGNED,
              status_type: ::Statuses::Types::FINE_LEGAL,
              color: '#7AC6EB'
            },
            {
              name: { es: 'Cerrada', en: 'Closed' },
              code: ::Statuses::FineLegal::FINE_LEGAL_CLOSED,
              status_type: ::Statuses::Types::FINE_LEGAL,
              color: '#8BE939'
            },
            {
              name: { es: 'Pendiente', en: 'Pending' },
              code: ::Statuses::FineLegal::FINE_LEGAL_PENDING,
              status_type: ::Statuses::Types::FINE_LEGAL,
              color: '#D6EAF3'
            },
            {
              name: { es: 'Rechazada', en: 'Rejected' },
              code: ::Statuses::FineLegal::FINE_LEGAL_REJECTED,
              status_type: ::Statuses::Types::FINE_LEGAL,
              color: '#F0553B'
            },
            {
              name: { es: 'Pagada', en: 'Paid' },
              code: ::Statuses::FineLegal::FINE_LEGAL_PAID,
              status_type: ::Statuses::Types::FINE_LEGAL,
              color: '#8BE939'
            },
            {
              name: { es: 'Advertencia Asignada', en: 'Warning Assigned' },
              code: ::Statuses::FineWarning::FINE_WARNING_ASSIGNED,
              status_type: ::Statuses::Types::FINE_WARNING,
              color: '#FFA726'
            },
            {
              name: { es: 'Advertencia Cerrada', en: 'Warning Closed' },
              code: ::Statuses::FineWarning::FINE_WARNING_CLOSED,
              status_type: ::Statuses::Types::FINE_WARNING,
              color: '#8BE939'
            },
            {
              name: { es: 'Advertencia Finalizada', en: 'Warning Finished' },
              code: ::Statuses::FineWarning::FINE_WARNING_FINISHED,
              status_type: ::Statuses::Types::FINE_WARNING,
              color: '#3B8FF0'
            },
            {
              name: { es: 'Reclamada', en: 'Claimed' },
              code: ::Statuses::FineLegal::FINE_LEGAL_CLAIM,
              status_type: ::Statuses::Types::FINE_LEGAL,
              color: '#3B8FF0'
            }
          ]
        end
      end
    end
  end
end
