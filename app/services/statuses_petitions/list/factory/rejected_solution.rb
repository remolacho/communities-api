# frozen_string_literal: true

class StatusesPetitions::List::Factory::RejectedSolution < StatusesPetitions::List::Factory::Base

  private

  # override
  def statuses
    return [Status.petition_pending] unless owner?

    [Status.petition_confirm]
  end

  # override
  def can_view?
    owner? || (petition.roles.ids & user.roles.ids).any?
  end

  def owner?
    user.id == petition.user_id
  end
end
