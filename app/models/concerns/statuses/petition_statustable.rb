module Statuses
  module PetitionStatustable
    extend ActiveSupport::Concern

    PETITION = 'petition'
    PETITION_PENDING = 'pet-pending'
    PETITION_REVIEWING = 'pet-reviewing'
    PETITION_REJECTED = 'pet-rejected'
    PETITION_CONFIRM = 'pet-confirm'
    PETITION_REJECTED_SOLUTION = 'pet-rejected-solution'
    PETITION_RESOLVE = 'pet-resolve'

    included do
      scope :all_of_petitions, lambda { |lang|
        where(status_type: PETITION)
          .select("id, code, color, name::json->>'#{lang}' as as_name")
      }

      scope :petition_pending, lambda {
        find_by(status_type: PETITION, code: PETITION_PENDING)
      }

      scope :petition_reviewing, lambda {
        find_by(status_type: PETITION, code: PETITION_REVIEWING)
      }

      scope :petition_rejected, lambda {
        find_by(status_type: PETITION, code: PETITION_REJECTED)
      }

      scope :petition_confirm, lambda {
        find_by(status_type: PETITION, code: PETITION_CONFIRM)
      }

      scope :petition_rejected_solution, lambda {
        find_by(status_type: PETITION, code: PETITION_REJECTED_SOLUTION)
      }

      scope :petition_resolve, lambda {
        find_by(status_type: PETITION, code: PETITION_RESOLVE)
      }
    end
  end
end
