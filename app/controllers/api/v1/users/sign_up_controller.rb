class Api::V1::Users::SignUpController < ApplicationController
  skip_before_action :authorized_user, :valid_subdomain!, :valid_user_active!

  # POST /:enterprise_subdomain/v1/users/sign_up
  def create
    ::Users::SignUpService.new(enterprise: enterprise, data: allowed_params).call

    render json: { success: true, message: I18n.t('services.users.sign_up.success') }
  end

  # GET /:enterprise_subdomain/v1/users/sign_up/active/:token
  def active_account
    ::Users::ActiveAccountService.new(token: params[:token]).call

    render json: { success: true, message: I18n.t('services.users.sign_up.success') }
  end

  private

  def allowed_params
    @allowed_params ||= params.require(:sign_up).permit(:name,
                                                        :lastname,
                                                        :identifier,
                                                        :email,
                                                        :reference,
                                                        :phone,
                                                        :password,
                                                        :password_confirmation)
  end
end
