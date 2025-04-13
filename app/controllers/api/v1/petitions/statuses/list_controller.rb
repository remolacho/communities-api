# frozen_string_literal: true

module Api
  module V1
    module Petitions
      module Statuses
        class ListController < ApplicationController
          # GET /:enterprise_subdomain/v1/petition/statuses/list/:token
          def index
            service = StatusesPetitions::List::FacadeService.new(user: current_user, petition: petition)

            render json: { success: true, data: service.build }
          end

          private

          def petition
            @petition ||= Petition.includes(:status).find_by!(token: params[:token])
          end
        end
      end
    end
  end
end
