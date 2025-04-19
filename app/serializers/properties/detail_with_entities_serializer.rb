# frozen_string_literal: true

module Properties
  class DetailWithEntitiesSerializer < ActiveModel::Serializer
    attributes :id,
               :location,
               :active,
               :enterprise_id,
               :property_type_id,
               :status_id,
               :property_type_name

    attribute :status_name do
      object.status_name[I18n.locale.to_s]
    end
  end
end
