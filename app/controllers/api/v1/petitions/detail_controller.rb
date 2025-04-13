# frozen_string_literal: true

module Api
  module V1
    module Petitions
      class DetailController < ApplicationController
        # GET /:enterprise_subdomain/v1/petition/detail/:token
        def show
          policy.can_read!

          render json: { success: true,
                         data: ::Petitions::DetailSerializer.new(petition,
                                                                 enterprise_subdomain: enterprise.subdomain) }
        end

        private

        def policy
          ::Petitions::Policy.new(current_user: current_user, petition: petition)
        end

        def petition
          @petition ||= Petition.find_by!(token: params[:token])
        end
      end
    end
  end
end
