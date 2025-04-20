# frozen_string_literal: true

module Statuses
  class Codes < EnumerateIt::Base
    associate_values(
      Statuses::Petition.enumeration.to_h.merge(
        Statuses::Answer.enumeration.to_h.merge(
          Statuses::Property.enumeration.to_h
        )
      )
    )
  end
end
