# frozen_string_literal: true

module Api
  module V1
    module UserRoles
      module Import
        class RemoveController < ApplicationController
          # DELETE /:enterprise_subdomain/v1/user_roles/import/remove
          def delete
            policy.can_write!

            service = ::UserRoles::Import::RemoveService.new(enterprise: enterprise, user: current_user,
                                                             file: allowed_params)
            service.perform

            message = if service.errors.empty?
                        I18n.t('services.user_roles.import.remove.success.ok')
                      else
                        I18n.t('services.user_roles.import.create.remove.error')
                      end

            render json: { success: true, message: message, errors: service.errors }
          end

          private

          def allowed_params
            @allowed_params ||= params[:user_roles_file]
          end

          def policy
            ::UserRoles::Import::Remove::Policy.new(current_user: current_user)
          end
        end
      end
    end
  end
end
