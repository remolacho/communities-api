# frozen_string_literal: true

module CategoryPetitions
  class DetailSerializer < ActiveModel::Serializer
    attributes :id, :name, :slug
  end
end
