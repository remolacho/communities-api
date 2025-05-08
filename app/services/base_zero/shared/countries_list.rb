# frozen_string_literal: true

module BaseZero
  module Shared
    class CountriesList
      class << self
        def list
          [
            {
              name: 'Colombia',
              code: 'CO',
              currency_code: 'COP',
              currency_symbol: '$',
              active: true
            },
            {
              name: 'México',
              code: 'MX',
              currency_code: 'MXN',
              currency_symbol: '$',
              active: true
            },
            {
              name: 'Perú',
              code: 'PE',
              currency_code: 'PEN',
              currency_symbol: 'S/',
              active: true
            },
            {
              name: 'Chile',
              code: 'CL',
              currency_code: 'CLP',
              currency_symbol: '$',
              active: true
            },
            {
              name: 'Argentina',
              code: 'AR',
              currency_code: 'ARS',
              currency_symbol: '$',
              active: true
            },
            {
              name: 'Ecuador',
              code: 'EC',
              currency_code: 'USD',
              currency_symbol: '$',
              active: true
            },
            {
              name: 'Brasil',
              code: 'BR',
              currency_code: 'BRL',
              currency_symbol: 'R$',
              active: true
            },
            {
              name: 'Estados Unidos',
              code: 'US',
              currency_code: 'USD',
              currency_symbol: '$',
              active: true
            }
          ]
        end
      end
    end
  end
end
