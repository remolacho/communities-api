# frozen_string_literal: true

module BaseZero
  module Shared
    class PropertyTypesList
      class << self
        def all
          [
            { name: 'Apartamento',
              location_regex: '^T[1-4]-P(1[0-6]|[1-9])-A((10[1-8])|(20[1-8])|(30[1-8])|(40[1-8])|(50[1-8])|(60[1-8])|(70[1-8])|(80[1-8])|(90[1-8])|(100[1-8])|(110[1-8])|(120[1-8])|(130[1-8])|(140[1-8])|(150[1-8])|(160[1-8]))$',
              placeholder: 'T1-P1-A101',
              code: 'apartamento' },
            { name: 'Local Comercial',
              location_regex: '^TE-L([1-9]|[1-9][0-9]|[1-9][0-9][0-9]|1000)$',
              placeholder: 'TE-L1',
              code: 'local' },
            { name: 'Parqueadero',
              location_regex: '^TE-P([1-9]|10)-E([1-9]|[1-9][0-9]|100)$',
              placeholder: 'TE-P1-E1',
              code: 'parqueadero' },
            { name: 'Parqueadero visitante',
              location_regex: '^TE-P([1-9]|10)-E([1-9]|[1-9][0-9]|100)$',
              placeholder: 'TE-P1-E1',
              code: 'parqueadero-v' },
            { name: 'Depósito',
              location_regex: '^TE-P([1-9]|10)-D([1-9]|[1-9][0-9]|100)$',
              placeholder: 'TE-P1-D1',
              code: 'deposito' },
            { name: 'Bicicletero',
              location_regex: '^TE-P([1-9]|10)-B([1-9]|[1-9][0-9]|100)$',
              placeholder: 'TE-P1-B1',
              code: 'bicicletero' },
            { name: 'Parqueadero discapacitado',
              location_regex: '^TE-P([1-9]|10)-E([1-9]|[1-9][0-9]|100)$',
              placeholder: 'TE-P1-E1',
              code: 'parqueadero-d' }
          ]
        end
      end
    end
  end
end
