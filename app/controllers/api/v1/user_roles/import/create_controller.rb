class Api::V1::UserRoles::Import::CreateController < ApplicationController

  # POST /:enterprise_subdomain/v1/user_roles/import/create
  def create
    policy.can_write!

    service = ::UserRoles::Import::CreateService.new(enterprise: enterprise, user: current_user, file: allowed_params)
    service.perform

    message = if service.errors.empty?
                I18n.t('services.user_roles.import.create.success.ok')
              else
                I18n.t('services.user_roles.import.create.success.error')
              end

    render json: {success: true, message: message, errors: service.errors}
  end

  private

  def allowed_params
    @allowed_params ||= params[:user_roles_file]
  end

  def policy
    ::UserRoles::Import::Create::Policy.new(current_user: current_user)
  end
end
