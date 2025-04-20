# frozen_string_literal: true

module BaseZero
  module Shared
    class CategoriesPetitionsList
      class << self
        def all
          [
            { name: 'Petición', slug: 'peticion' },
            { name: 'Queja', slug: 'queja' },
            { name: 'Reclamo', slug: 'reclamo' },
            { name: 'Agresión', slug: 'agresion' }
          ]
        end
      end
    end
  end
end
