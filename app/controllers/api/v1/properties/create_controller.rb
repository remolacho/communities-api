# frozen_string_literal: true

module Api
  module V1
    module Properties
      class CreateController < ApplicationController
        # POST /api/v1/properties/create
        def create
          policy.can_write!

          property = ::Properties::CreateService.new(
            user: current_user,
            params: allowed_params
          ).call

          render json: {
            success: true,
            property: ::Properties::DetailSerializer.new(property).as_json
          }
        end

        private

        def allowed_params
          params.require(:property).permit(
            :property_type_id,
            :location,
            :status_id
          )
        end

        def policy
          @policy ||= ::Properties::Policy.new(current_user: current_user)
        end
      end
    end
  end
end
