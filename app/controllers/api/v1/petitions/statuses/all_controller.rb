# frozen_string_literal: true

module Api
  module V1
    module Petitions
      module Statuses
        class AllController < ApplicationController
          # GET /:enterprise_subdomain/v1/petition/statuses/all
          def index
            render json: { success: true, data: Status.all_of_petitions(language) }
          end
        end
      end
    end
  end
end
