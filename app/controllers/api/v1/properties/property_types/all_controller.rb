# frozen_string_literal: true

module Api
  module V1
    module Properties
      module PropertyTypes
        class AllController < ApplicationController
          # GET /:enterprise_subdomain/v1/properties/property_types/all
          def index
            policy.can_read!

            render json: { success: true, data: PropertyType.active }
          end

          private

          def policy
            @policy ||= ::Properties::Policy.new(current_user: current_user)
          end
        end
      end
    end
  end
end
