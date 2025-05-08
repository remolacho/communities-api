# frozen_string_literal: true

module BaseZero
  class CreatePropertyTypesService
    attr_reader :enterprise, :property_types

    def initialize(enterprise)
      @enterprise = enterprise
      @property_types = Shared::PropertyTypesList.all
    end

    def call
      create_types
    end

    private

    def create_types
      property_types.each do |attrs|
        PropertyType.find_or_create_by!(attrs.merge(enterprise: enterprise))
      end
    end
  end
end
