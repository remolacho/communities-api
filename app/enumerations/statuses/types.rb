# frozen_string_literal: true

module Statuses
  class Types < EnumerateIt::Base
    associate_values(
      petition: 'petition',
      answer: 'answer',
      property: 'property',
      fine_legal: 'fine-legal',
      fine_warning: 'fine-warning'
    )
  end
end
