class Api::V1::Petitions::CreateController < ApplicationController

  # POST   /:enterprise_subdomain/v1/petition/create
  def create
    petition = ::Petitions::CreateService.new(user: current_user, data: allowed_params).call
    render json: {success: true, data: { ticket: petition.ticket, token: petition.token} }
  end

  private

  def allowed_params
    @allowed_params ||= params.require(:petition).permit!
  end
end
