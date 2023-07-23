class Status
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
      scope :petition_pending, -> {
        find_by(status_type: PETITION, code: PETITION_PENDING)
      }

      scope :petition_resolve, -> {
        find_by(status_type: PETITION, code: PETITION_RESOLVE)
      }

      scope :petition_reviewing, -> {
        find_by(status_type: PETITION, code: PETITION_REVIEWING)
      }
    end
  end
end
