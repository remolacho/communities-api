# frozen_string_literal: true

class UpdateStatusPetition::Policy < BasePolicy
  attr_accessor :petition, :status

  def initialize(current_user:, petition:, status:)
    super(current_user: current_user)

    @petition = petition
    @status = status
  end

  def can_write!
    loudly do
      statuses.exists?(status.code)
    end
  end

  private

  def statuses
    ::StatusesPetitions::List::AllowedCodesService.new(user: current_user, petition: petition)
  end
end
