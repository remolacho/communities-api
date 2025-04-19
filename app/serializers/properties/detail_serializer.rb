# frozen_string_literal: true

module Properties
  class DetailSerializer < ActiveModel::Serializer
    attributes :id,
               :location,
               :active,
               :enterprise_id,
               :property_type_id,
               :status_id
  end
end
