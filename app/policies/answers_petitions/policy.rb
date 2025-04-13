# frozen_string_literal: true

module AnswersPetitions
  class Policy < BasePolicy
    attr_accessor :petition

    def initialize(current_user:, petition:)
      super(current_user: current_user)

      @petition = petition
    end

    def can_read!
      loudly do
        owner? || has_role?
      end
    end

    def can_write!
      loudly do
        owner? || has_role?
      end
    end

    private

    def owner?
      petition.user_id == current_user.id
    end

    def has_role?
      (petition.roles.ids & current_user.roles.ids).any?
    end
  end
end
