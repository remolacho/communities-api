# frozen_string_literal: true

module Petitions
  class UpdateStatusService
    attr_accessor :user, :petition, :status

    def initialize(user:, petition:, status:)
      @user = user
      @status = status
      @petition = petition
    end

    def call
      petition.status = status
      petition.save!
    end
  end
end
