# frozen_string_literal: true

class StatusesPetitions::List::FacadeService
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
    return StatusesPetitions::List::Factory::Pending.new(user: user, petition: petition)          if petition.pending?
    return StatusesPetitions::List::Factory::Rejected.new(user: user, petition: petition)         if petition.rejected?
    return StatusesPetitions::List::Factory::Reviewing.new(user: user, petition: petition)        if petition.reviewing?

    if petition.by_confirm?
      return StatusesPetitions::List::Factory::Confirm.new(user: user,
                                                           petition: petition)
    end
    if petition.rejected_solution?
      return StatusesPetitions::List::Factory::RejectedSolution.new(user: user,
                                                                    petition: petition)
    end
    return StatusesPetitions::List::Factory::Resolved.new(user: user, petition: petition) if petition.resolved?

    raise NotImplementedError
  end
end
