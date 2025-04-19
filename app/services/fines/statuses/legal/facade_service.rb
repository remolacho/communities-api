# frozen_string_literal: true

module Fines
  module Statuses
    module Legal
      class FacadeService
        attr_accessor :user, :fine

        def initialize(user:, fine:)
          @user = user
          @fine = fine
        end

        def build
          factory.call
        end

        private

        def factory
          return Assigned.new(user: user, fine: fine) if fine.legal_assigned?
          return Claim.new(user: user, fine: fine)    if fine.legal_claim?
          return Closed.new(user: user, fine: fine)   if fine.legal_closed?
          return Rejected.new(user: user, fine: fine) if fine.legal_rejected?
          return Pending.new(user: user, fine: fine)  if fine.legal_pending?
          return Paid.new(user: user, fine: fine)     if fine.legal_paid?

          raise NotImplementedError
        end
      end
    end
  end
end
