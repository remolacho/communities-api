module Statuses
  module PropertyStatustable
    extend ActiveSupport::Concern

    PROPERTY = 'property'
    PROPERTY_OWN = 'pro-own'
    PROPERTY_RENTED = 'pro-rented'
    PROPERTY_LOAN = 'pro-loan'

    included do
        scope :all_of_properties, ->(lang) {
          where(status_type: PROPERTY)
            .select("id, code, color, name::json->>'#{lang}' as as_name")
        }

        scope :property_own, -> {
          find_by(status_type: PROPERTY, code: PROPERTY_OWN)
        }

        scope :property_rented, -> {
          find_by(status_type: PROPERTY, code: PROPERTY_RENTED)
        }

        scope :property_loan, -> {
          find_by(status_type: PROPERTY, code: PROPERTY_LOAN)
        }
    end
  end
end
