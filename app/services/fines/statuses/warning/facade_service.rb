# frozen_string_literal: true

module Fines
  module Statuses
    module Warning
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
          return Assigned.new(user: user, fine: fine) if fine.warning_assigned?
          return Closed.new(user: user, fine: fine)   if fine.warning_closed?
          return Finished.new(user: user, fine: fine) if fine.warning_finished?

          raise NotImplementedError
        end
      end
    end
  end
end
