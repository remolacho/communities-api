# frozen_string_literal: true

module Fines
  module Categories
    class DetailSerializer < ActiveModel::Serializer
      attributes :id,
                 :name,
                 :description,
                 :code,
                 :formula,
                 :value,
                 :active,
                 :parent_category_fine_id
    end
  end
end
