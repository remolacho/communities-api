# frozen_string_literal: true

module BaseZero
  module Shared
    class PropertyOwnerTypesList
      class << self
        def all
          [
            { code: 'propietario', name: 'Propietario' },
            { code: 'propietario-legal', name: 'Propietario Legal' },
            { code: 'inquilino', name: 'Inquilino' },
            { code: 'hipoteca', name: 'Hipoteca' },
            { code: 'leasing', name: 'Leasing habitacional' }
          ]
        end
      end
    end
  end
end
