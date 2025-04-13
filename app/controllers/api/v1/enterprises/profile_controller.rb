# frozen_string_literal: true

module Api
  module V1
    module Enterprises
      class ProfileController < ApplicationController
        # GET /:enterprise_subdomain/v1/enterprise/profile?lang=es
        def index
          policy.can_read!

          render json: { success: true,
                         data: ::Enterprises::ProfileSerializer.new(current_user.enterprise).as_json }
        end

        private

        def policy
          @policy ||= ::Enterprises::Profile::Policy.new(current_user: current_user)
        end
      end
    end
  end
end
