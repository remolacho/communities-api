# frozen_string_literal: true

module Api
  module V1
    module Properties
      module Statuses
        class AllController < ApplicationController
          # GET  /:enterprise_subdomain/v1/properties/statuses/all
          def index
            render json: { success: true, data: Status.all_of_properties(language) }
          end
        end
      end
    end
  end
end
