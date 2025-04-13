# frozen_string_literal: true

module Api
  module V1
    module Petitions
      module Dashboard
        class ChartStatusesController < ApplicationController
          #  GET /:enterprise_subdomain/v1/petition/dashboard/chart_statuses
          def index
            chart = ::Petitions::Dashboard::ChartStatusesService.new(user: current_user, statuses: statuses)

            render json: {
              success: true,
              data: chart.call
            }
          end

          private

          def statuses
            @statuses ||= Status.all_of_petitions(language)
          end
        end
      end
    end
  end
end
