# frozen_string_literal: true

class Api::V1::Users::SignInController < ApplicationController
  skip_before_action :authorized_user

  # POST /:enterprise_subdomain/v1/users/sign_in?lang=es
  def create
    service = ::Users::SignInService.new(email: allowed_params[:email],
                                         password: allowed_params[:password]).call

    render json: { success: true, data: { jwt: service.jwt } }
  end

  private

  def allowed_params
    @allowed_params ||= params.require(:sign_in).permit(:email, :password)
  end
end
