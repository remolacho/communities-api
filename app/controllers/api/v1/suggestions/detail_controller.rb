# frozen_string_literal: true

module Api
  module V1
    module Suggestions
      class DetailController < ApplicationController
        # GET /:enterprise_subdomain/v1/suggestion/detail/:token
        def show
          policy.can_read!

          service_suggestion = ::Suggestions::ReadService.new(user: current_user,
                                                              suggestion: suggestion).call

          render json: { success: true,
                         data: ::Suggestions::DetailSerializer.new(service_suggestion,
                                                                   enterprise_subdomain: enterprise.subdomain) }
        end

        private

        def policy
          ::Suggestions::Detail::Policy.new(current_user: current_user,
                                            suggestion: suggestion)
        end

        def suggestion
          @suggestion ||= Suggestion.find_by!(token: params[:token])
        end
      end
    end
  end
end
