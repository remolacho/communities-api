class Api::V1::Petitions::CreateController < ApplicationController

  # POST   /:enterprise_subdomain/v1/petitions/create
  def create
    service = ::Petitions::CreateService.new(user: current_user, data: allowed_params)
    render json: {success: true, data: { ticket: service.call.ticket } }
  end

  private

  def allowed_params
    @allowed_params ||= params.require(:petition).permit(:title,
                                                         :message,
                                                         :category_petition_id,
                                                         :group_role_id )
  end
end
