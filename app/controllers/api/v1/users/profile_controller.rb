# frozen_string_literal: true

class Api::V1::Users::ProfileController < ApplicationController

  # GET /:enterprise_subdomain/v1/users/profile/show?lang=&token=
  def show
    policy.can_read!

    render json: {success: true,  data: ::Users::ProfileSerializer.new(profile,
                                                                       enterprise_subdomain: enterprise.subdomain,
                                                                       current_user: current_user).as_json}
  end

  private

  def policy
    @policy ||= Users::Profile::Policy.new(current_user: current_user, profile: profile)
  end

  def profile
    @profile ||= params[:token].present? ? User.find_by!(token: params[:token]) : current_user
  end
end
