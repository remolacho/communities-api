# frozen_string_literal: true

module Properties
  class DetailWithEntitiesSerializer < ActiveModel::Serializer
    attributes :id,
               :location,
               :active,
               :enterprise_id,
               :property_type_id,
               :status_id,
               :property_type_name,
               :status_name
  end
end
