# frozen_string_literal: true

module Api
  module V1
    module Fines
      module Statuses
        class AllController < ApplicationController
          # GET /:enterprise_subdomain/v1/fines/statuses/all/:type
          def index
            policy.can_read!

            render json: { success: true, data: statuses }
          end

          private

          def statuses
            case params[:type]
            when 'legal'
              Status.all_of_fine_legals(language)
            when 'warning'
              Status.all_of_fine_warnings(language)
            else
              raise ActiveRecord::RecordInvalid, 'Invalid route'
            end
          end

          def policy
            @policy ||= ::Fines::Policy.new(current_user: current_user)
          end
        end
      end
    end
  end
end
