# frozen_string_literal: true

module StatusesPetitions
  module List
    class FacadeService
      attr_accessor :user, :petition

      def initialize(user:, petition:)
        @user = user
        @petition = petition
      end

      def build
        factory.call
      end

      private

      def factory
        return Factory::Pending.new(user: user, petition: petition)          if petition.pending?
        return Factory::Rejected.new(user: user, petition: petition)         if petition.rejected?
        return Factory::Reviewing.new(user: user, petition: petition)        if petition.reviewing?

        if petition.by_confirm?
          return Factory::Confirm.new(user: user,
                                      petition: petition)
        end
        if petition.rejected_solution?
          return Factory::RejectedSolution.new(user: user,
                                               petition: petition)
        end
        return Factory::Resolved.new(user: user, petition: petition) if petition.resolved?

        raise NotImplementedError
      end
    end
  end
end
