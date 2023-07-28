class Api::V1::Petitions::UpdateStatusController < ApplicationController

  # PUT /:enterprise_subdomain/v1/petition/update_status/:token
  def update
    policy.can_write!

    Petitions::UpdateStatusService.new(user: current_user, petition: petition, status: status).call

    render json: { success: true, message: I18n.t('services.petitions.update_status.success')}
  end

  private

  def policy
    @policy ||= ::UpdateStatusPetition::Policy.new(current_user: current_user,
                                                   petition: petition,
                                                   status: status)
  end

  def petition
    @petition ||= Petition.includes(:status).find_by!(token: params[:token])
  end

  def status
    Status.find(allowed_params[:status_id])
  end

  def allowed_params
    @allowed_params ||= params.require(:petition).permit(:status_id)
  end
end
