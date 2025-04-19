# frozen_string_literal: true

module Api
  module V1
    module UserProperties
      module Import
        class RemoveController < ApplicationController
          # DELETE /:enterprise_subdomain/v1/user_properties/import/remove
          def delete
            policy.can_destroy!

            service = ::UserProperties::Import::RemoveService.new(
              user: current_user,
              file: allowed_params
            )
            service.call

            render json: {
              success: true,
              message: I18n.t('services.user_properties.import.remove.success')
            }
          end

          private

          def allowed_params
            @allowed_params ||= params[:user_properties_file]
          end

          def policy
            ::UserProperties::Import::Remove::Policy.new(current_user: current_user)
          end
        end
      end
    end
  end
end
