# frozen_string_literal: true

module Petitions
  class Policy < BasePolicy
    attr_accessor :petition

    def initialize(current_user:, petition:)
      super(current_user: current_user)

      @petition = petition
    end

    def can_read!
      loudly do
        owner? || role_petition?(:can_read)
      end
    end

    def can_write!
      loudly do
        owner? || role_petition?(:can_write)
      end
    end

    private

    def owner?
      petition.user_id == current_user.id
    end

    def role_petition?(permission)
      role?(permission) && (petition.roles.ids & current_user.roles.ids).any?
    end

    # override
    def entity
      @entity ||= Petition.name
    end
  end
end
