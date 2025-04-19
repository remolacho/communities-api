# frozen_string_literal: true

module Api
  module V1
    module Properties
      # POST /api/v1/properties/update
      class UpdateController < ApplicationController
        def update
          policy.can_write!

          result = ::Properties::UpdateService.new(property, property_params, current_user).call

          render json: {
            success: true,
            property: ::Properties::DetailSerializer.new(result).as_json
          }
        end

        private

        def property
          @property ||= Property.find(params[:id])
        end

        def property_params
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
