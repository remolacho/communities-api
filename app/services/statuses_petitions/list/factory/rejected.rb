# frozen_string_literal: true

class StatusesPetitions::List::Factory::Rejected < StatusesPetitions::List::Factory::Base
  private

  # override
  def statuses
    [Status.petition_pending]
  end

  # override
  def can_view?
    (petition.roles.ids & user.roles.ids).any?
  end
end
