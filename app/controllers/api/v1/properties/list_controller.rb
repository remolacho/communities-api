# frozen_string_literal: true

module Api
  module V1
    module Properties
      # GET /api/v1/properties/list
      class ListController < ApplicationController
        def index
          policy.can_read!

          render json: {
            success: true,
            data: serializer,
            paginate: paginate
          }
        end

        private

        def serializer
          ActiveModelSerializers::SerializableResource.new(
            properties_list,
            each_serializer: ::Properties::DetailWithEntitiesSerializer
          ).as_json
        end

        def paginate
          {
            limit: properties_list.limit_value,
            total_pages: properties_list.total_pages,
            current_page: properties_list.current_page
          }
        end

        def properties_list
          @properties_list ||= service.call(params[:page])
        end

        def service
          @service ||= ::Properties::ListService.new(
            user: current_user,
            filter: filter
          )
        end

        def filter
          @filter ||= ::Properties::Searches::QueryTermService.new(params)
        end

        def policy
          @policy ||= ::Properties::Policy.new(current_user: current_user)
        end
      end
    end
  end
end
