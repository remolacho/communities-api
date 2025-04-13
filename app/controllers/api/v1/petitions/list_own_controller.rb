# frozen_string_literal: true

module Api
  module V1
    module Petitions
      class ListOwnController < ApplicationController
        # GET /:enterprise_subdomain/v1/petition/list_own
        def index
          render json: { success: true, data: serializer, paginate: paginate }
        end

        private

        def serializer
          ActiveModelSerializers::SerializableResource.new(petition_list,
                                                           each_serializer: ::Petitions::DetailSerializer,
                                                           enterprise_subdomain: enterprise.subdomain).as_json
        end

        def paginate
          {
            limit: petition_list.limit_value,
            total_pages: petition_list.total_pages,
            current_page: petition_list.current_page
          }
        end

        def petition_list
          @petition_list ||= service.call
        end

        def service
          @service ||= ::Petitions::List::ListOwnService.new(user: current_user,
                                                             filter: filter,
                                                             page: params[:page])
        end

        def filter
          ::Petitions::Filter::QueryService.new(params: params)
        end
      end
    end
  end
end
