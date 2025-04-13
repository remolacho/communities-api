# frozen_string_literal: true

module Api
  module V1
    module Properties
      module Import
        # POST /api/v1/properties/import/create
        class CreateController < ApplicationController
          def create
            policy.can_write!

            ::Properties::Import::CreateService.new(
              file: allowed_params
            ).call
          end

          private

          def allowed_params
            @allowed_params ||= params[:property_import_file]
          end

          def policy
            @policy ||= ::Properties::Policy.new(current_user: current_user)
          end
        end
      end
    end
  end
end
