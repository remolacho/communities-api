# frozen_string_literal: true

class StatusesPetitions::List::Factory::Resolved < StatusesPetitions::List::Factory::Base
  private

  # override
  def can_view?
    false
  end
end
