# frozen_string_literal: true

class Api::V1::Users::SignInController < ApplicationController
  skip_before_action :authorized_user

  # POST /:enterprise_subdomain/v1/users/sign_in?lang=es
  def create
    user_service = ::Users::SignInService.new(email: allowed_params[:email], password: allowed_params[:password])
    jwt_service =  ::Users::BuildJwtService.new(user: user_service.call)

    render json: { success: true, data: { jwt: jwt_service.build } }
  end

  private

  def allowed_params
    @allowed_params ||= params.require(:sign_in).permit(:email, :password)
  end
end