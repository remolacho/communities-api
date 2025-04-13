class Api::V1::CategoriesPetitions::ListController < ApplicationController
  # GET /:enterprise_subdomain/v1/categories_petitions/list
  def index
    render json: { success: true, data: serializer }
  end

  private

  def serializer
    ActiveModelSerializers::SerializableResource.new(CategoryPetition.all,
                                                     each_serializer: ::CategoryPetitions::DetailSerializer).as_json
  end
end
