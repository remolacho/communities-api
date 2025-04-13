class Api::V1::Petitions::Answers::Files::ListController < ApplicationController
  # GET /:enterprise_subdomain/v1/petition/answer/files/:id/list
  def list
    policy.can_read!

    service = ::AnswersPetitions::Files::ListService.new(enterprise: enterprise,
                                                         user: current_user,
                                                         answer: answer)

    render json: { success: true, data: service.call }
  end

  private

  def policy
    ::AnswersPetitions::Policy.new(current_user: current_user, petition: answer.petition)
  end

  def answer
    @answer ||= AnswersPetition.find(params[:id])
  end
end
