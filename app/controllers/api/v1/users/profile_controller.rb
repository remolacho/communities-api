# frozen_string_literal: true

class Api::V1::Users::ProfileController < ApplicationController

  # GET /:enterprise_subdomain/v1/users/profile/show
  def show
    render json: {success: true,  data: ::Users::ProfileSerializer.new(current_user).as_json}
  end
end
