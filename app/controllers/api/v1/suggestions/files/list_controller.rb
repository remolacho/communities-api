class Api::V1::Suggestions::Files::ListController < ApplicationController

  # GET /:enterprise_subdomain/v1/suggestion/files/:token/list
  def list
    policy.can_read!

    service =  ::Suggestions::Files::ListService.new(enterprise: enterprise,
                                                     user: current_user,
                                                     suggestion: suggestion)

    render json: {success: true, data: service.call}
  end

  private
  def policy
    ::Suggestions::Detail::Policy.new(current_user: current_user, suggestion: suggestion)
  end

  def suggestion
    @suggestion ||= Suggestion.find_by!(token: params[:token])
  end
end
