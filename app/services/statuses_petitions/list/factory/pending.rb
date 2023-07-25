# frozen_string_literal: true

class StatusesPetitions::List::Factory::Pending < StatusesPetitions::List::Factory::Base

  private

  # override
  def statuses
    [
      Status.petition_reviewing,
      Status.petition_rejected
    ]
  end

  # override
  def can_view?
    (petition.roles.ids & user.roles.ids).any?
  end
end
