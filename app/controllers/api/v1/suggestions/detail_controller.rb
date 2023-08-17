class Api::V1::Suggestions::DetailController < ApplicationController

  # GET /:enterprise_subdomain/v1/suggestion/detail/:token
  def show
    policy.can_read!

    render json: {success: true,  data: ::Suggestions::DetailSerializer.new(suggestion,
                                                                            enterprise_subdomain: enterprise.subdomain)}
  end

  private

  def policy
    ::Suggestions::Detail::Policy.new(current_user: current_user, suggestion: suggestion)
  end

  def suggestion
    @suggestion ||= Suggestion.find_by!(token: params[:token])
  end
end
