# frozen_string_literal: true

class Api::V1::Users::ForgotPasswordController < ApplicationController
  skip_before_action :authorized_user

  # POST /:enterprise_subdomain/v1/users/forgot_password?lang=es
  def create
    ::Users::ForgotPasswordService.new(email: allowed_params[:email]).call

    render json: { success: true, message: I18n.t("services.users.forgot_password.success") }
  end

  private

  def allowed_params
    @allowed_params ||= params.require(:forgot_password).permit(:email)
  end
end