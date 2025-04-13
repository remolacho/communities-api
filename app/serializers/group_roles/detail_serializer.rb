# frozen_string_literal: true

module GroupRoles
  class DetailSerializer < ActiveModel::Serializer
    attributes :id
    attribute :name

    def name
      object.name[I18n.locale.to_s]
    end
  end
end
