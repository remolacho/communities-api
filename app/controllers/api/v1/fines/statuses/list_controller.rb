# frozen_string_literal: true

module Api
  module V1
    module Fines
      module Statuses
        class ListController < ApplicationController
          # GET /:enterprise_subdomain/v1/fines/statuses/list/:token
          def index
            service = ::Fines::Statuses::Factory.new(user: current_user, fine: fine)

            render json: { success: true, data: service.call.build }
          end

          private

          def fine
            @fine ||= Fine.find_by!(token: params[:token])
          end
        end
      end
    end
  end
end
