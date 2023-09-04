class Api::V1::Suggestions::CreateController < ApplicationController

  # POST   /:enterprise_subdomain/v1/suggestion/create
  def create
    suggestion = ::Suggestions::CreateService.new(user: current_user, data: allowed_params).call
    render json: {success: true,
                  data: {
                    ticket: suggestion.ticket,
                    token: suggestion.token
                  },
                  message: I18n.t('services.suggestions.create.success') }
  end

  private

  def allowed_params
    @allowed_params ||= params.require(:suggestion).permit!
  end
end
