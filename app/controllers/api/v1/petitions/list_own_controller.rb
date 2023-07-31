class Api::V1::Petitions::ListOwnController < ApplicationController

  # GET /:enterprise_subdomain/v1/petition/list_own
  def index
    service = Petitions::List::ListOwnService.new(user: current_user,
                                                  filter: filter,
                                                  page: params[:page])

    service.call

    render json: {success: true, data: []}
  end

  private

  def filter
    ::Petitions::Filter::QueryService.new(params)
  end
end
