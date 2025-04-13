class Api::V1::Suggestions::ListOwnController < ApplicationController
  # GET /:enterprise_subdomain/v1/suggestion/list_own
  def index
    render json: { success: true, data: serializer, paginate: paginate }
  end

  private

  def serializer
    ActiveModelSerializers::SerializableResource.new(suggestion_list,
                                                     each_serializer: ::Suggestions::DetailSerializer,
                                                     enterprise_subdomain: enterprise.subdomain).as_json
  end

  def paginate
    {
      limit: suggestion_list.limit_value,
      total_pages: suggestion_list.total_pages,
      current_page: suggestion_list.current_page
    }
  end

  def suggestion_list
    @suggestion_list ||= service.call
  end

  def service
    @service ||= ::Suggestions::List::ListOwnService.new(user: current_user,
                                                         filter: filter,
                                                         page: params[:page])
  end

  def filter
    ::Suggestions::Filter::QueryService.new(params: params)
  end
end
