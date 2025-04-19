# frozen_string_literal: true

module Api
  module V1
    module Fines
      module Categories
        class ListController < ApplicationController
          # GET /:enterprise_subdomain/v1/fines/categories/list
          def index
            policy.can_read!

            render json: { success: true, data: serializer, paginate: paginate }
          end

          private

          def serializer
            ActiveModelSerializers::SerializableResource.new(service.hierarchy,
                                                             each_serializer: ::Fines::Categories::DetailSerializer)
              .as_json
          end

          def paginate
            {
              limit: service.roots.limit_value,
              total_pages: service.roots.total_pages,
              current_page: service.roots.current_page
            }
          end

          def service
            @service ||= ::Fines::Categories::ListService.new(user: current_user,
                                                              page: params[:page])
          end

          def policy
            @policy ||= ::CategoriesFines::Policy.new(current_user: current_user)
          end
        end
      end
    end
  end
end
