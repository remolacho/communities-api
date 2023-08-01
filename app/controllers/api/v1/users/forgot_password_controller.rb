# frozen_string_literal: true

class Api::V1::Users::ForgotPasswordController < ApplicationController
  skip_before_action :authorized_user, :valid_subdomain!, :valid_user_active!

  # POST /:enterprise_subdomain/v1/users/forgot_password?lang=es
  def create
    ::Users::ForgotPasswordService.new(email: allowed_params[:email]).call

    render json: { success: true, message: I18n.t("services.users.forgot_password.success") }
  end

  # GET /:enterprise_subdomain/v1/users/forgot_password/verifier/:token
  def verifier
    verifier = ::Users::VerifierChangePasswordService.new(token: params[:token])

    render json: { success: true, message: '', data: { token: verifier.call.reset_password_key } }
  end

  # POST /:enterprise_subdomain/v1/users/forgot_password/change/:token
  def change
    ::Users::ChangePasswordService.new(token: params[:token], data: allowed_params_change).call

    render json: { success: true, message: I18n.t('services.users.forgot_password.change.success') }
  end

  private

  def allowed_params_change
    @allowed_params_change ||=  params.require(:forgot_password).permit(:password, :password_confirmation)
  end

  def allowed_params
    @allowed_params ||= params.require(:forgot_password).permit(:email)
  end
end
