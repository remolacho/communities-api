# frozen_string_literal: true

module BaseZero
  class CreateCountriesService
    attr_reader :countries

    def initialize
      @countries = Shared::CountriesList.list
    end

    def call
      create_countries
    end

    private

    def create_countries
      countries.each do |country|
        Country.find_or_create_by!(code: country[:code], currency_code: country[:currency_code]) do |c|
          c.name = country[:name]
          c.currency_symbol = country[:currency_symbol]
          c.active = country[:active]
        end
      end
    end
  end
end
