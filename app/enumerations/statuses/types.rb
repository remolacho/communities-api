# frozen_string_literal: true

module Statuses
  class Types < EnumerateIt::Base
    associate_values(
      petition: 'petition',
      answer: 'answer',
      property: 'property'
    )
  end
end
