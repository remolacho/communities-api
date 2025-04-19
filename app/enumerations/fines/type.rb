# frozen_string_literal: true

module Fines
  class Type < EnumerateIt::Base
    associate_values(
      fine_legal: 'fine-legal',
      fine_warning: 'fine-warning'
    )
  end
end
