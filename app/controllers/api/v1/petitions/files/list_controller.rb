class Api::V1::Petitions::Files::ListController < ApplicationController
  def list
    policy.can_read!

    service = ::Petitions::Files::ListService.new(enterprise: enterprise,
                                                  user: current_user,
                                                  petition: petition)

    render json: { success: true, data: service.call }
  end

  private

  def policy
    ::Petitions::Policy.new(current_user: current_user, petition: petition)
  end

  def petition
    @petition ||= Petition.find_by!(token: params[:token])
  end
end
