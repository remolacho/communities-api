class Api::V1::Petitions::Answers::ListController < ApplicationController
  # GET /:enterprise_subdomain/v1/petition/answers/list/:token
  def index
    policy.can_read!

    service = ::AnswersPetitions::ListService.new(user: current_user, petition: petition)

    render json: { success: true, data: service.call }
  end

  private

  def policy
    ::AnswersPetitions::Policy.new(current_user: current_user, petition: petition)
  end

  def petition
    @petition ||= Petition.find_by!(token: params[:token])
  end
end
