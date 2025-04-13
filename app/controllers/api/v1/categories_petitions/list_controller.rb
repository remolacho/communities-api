# frozen_string_literal: true

module Api
  module V1
    module CategoriesPetitions
      class ListController < ApplicationController
        # GET /:enterprise_subdomain/v1/categories_petitions/list
        def index
          render json: { success: true, data: serializer }
        end

        private

        def serializer
          ActiveModelSerializers::SerializableResource
            .new(CategoryPetition.all,
                 each_serializer: ::CategoryPetitions::DetailSerializer)
            .as_json
        end
      end
    end
  end
end
