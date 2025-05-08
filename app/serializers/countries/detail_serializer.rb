# frozen_string_literal: true

module Countries
  class DetailSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :code,
               :currency_code,
               :currency_symbol
  end
end
