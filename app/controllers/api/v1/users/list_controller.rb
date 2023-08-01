# frozen_string_literal: true

class Api::V1::Users::ListController < ApplicationController

  # GET /:enterprise_subdomain/v1/users/list
  def index
    render json: {success: true, data: serializer, paginate: paginate}
  end

  private

  def serializer
    ActiveModelSerializers::SerializableResource.new(user_list,
                                                     each_serializer: ::Users::ProfileSerializer).as_json
  end

  def paginate
    {
      limit: user_list.limit_value,
      total_pages: user_list.total_pages,
      current_page: user_list.current_page
    }
  end

  def user_list
    @user_list ||= service.call(params[:page])
  end

  def service
    @service ||= ::Users::ListService.new(user: current_user,
                                          enterprise: enterprise,
                                          attr: params[:attr],
                                          search_term: params[:term])
  end
end
