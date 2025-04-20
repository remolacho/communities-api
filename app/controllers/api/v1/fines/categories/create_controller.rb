# frozen_string_literal: true

module Api
  module V1
    module Fines
      module Categories
        class CreateController < ApplicationController
          # POST /:enterprise_subdomain/v1/fines/categories/create
          def create
            policy.can_write!

            render json: { success: true, data: serializer }
          end

          private

          def serializer
            ActiveModelSerializers::SerializableResource.new(category,
                                                             serializer: ::Fines::Categories::DetailSerializer)
              .as_json
          end

          def category
            @category ||= service.call
          end

          def service
            @service ||= ::Fines::Categories::CreateService.new(
              user: current_user,
              **category_params
            )
          end

          def policy
            @policy ||= ::CategoriesFines::Policy.new(current_user: current_user)
          end

          def category_params
            params.require(:category_fine).permit!
          end
        end
      end
    end
  end
end
