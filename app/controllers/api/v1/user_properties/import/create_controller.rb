# frozen_string_literal: true

module Api
  module V1
    module UserProperties
      module Import
        class CreateController < ApplicationController
          # POST /:enterprise_subdomain/v1/user_properties/import/create
          def create
            policy.can_write!

            service = ::UserProperties::Import::CreateService.new(
              user: current_user,
              file: allowed_params
            )
            service.call

            render json: {
              success: true,
              message: I18n.t('services.user_properties.import.create.success')
            }
          end

          private

          def allowed_params
            @allowed_params ||= params[:user_properties_file]
          end

          def policy
            ::UserProperties::Import::Create::Policy.new(current_user: current_user)
          end
        end
      end
    end
  end
end
