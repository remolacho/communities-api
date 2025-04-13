# frozen_string_literal: true

module BaseZero
  class CreatePropertyOwnerTypesService
    attr_reader :enterprise, :property_owner_types

    def initialize(enterprise)
      @enterprise = enterprise
      @property_owner_types = Shared::PropertyOwnerTypesList.all
    end

    def call
      create_types
    end

    private

    def create_types
      property_owner_types.each do |attrs|
        PropertyOwnerType.find_or_create_by!(attrs.merge(enterprise: enterprise))
      end
    end
  end
end
