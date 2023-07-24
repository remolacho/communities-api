class Api::V1::Petitions::DetailController < ApplicationController

  # GET /:enterprise_subdomain/v1/petition/detail/:token
  def show
    policy.can_read!

    render json: {success: true,  data: ::Petitions::DetailSerializer.new(petition)}
  end

  private

  def policy
    ::Petitions::Policy.new(current_user: current_user, petition: petition)
  end

  def petition
    @petition ||= Petition.find_by!(token: params[:token])
  end
end
