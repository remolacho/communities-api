# frozen_string_literal: true

module Statuses
  class DetailSerializer < ActiveModel::Serializer
    attributes :id, :code, :color
    attribute :name

    def name
      object.name[I18n.locale.to_s]
    end
  end
end
