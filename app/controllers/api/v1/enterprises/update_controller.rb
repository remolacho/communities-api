# frozen_string_literal: true

module Api
  module V1
    module Enterprises
      class UpdateController < ApplicationController
        # PUT /:enterprise_subdomain/v1/enterprise/update/:token
        def update
          policy.can_write!

          valid_enterprise!

          ::Enterprises::UpdateService.new(user: current_user,
                                           enterprise: current_enterprise,
                                           data: allowed_params).call

          render json: { success: true, message: I18n.t('services.enterprises.update.success') }
        end

        private

        def policy
          @policy ||= ::Enterprises::Update::Policy.new(current_user: current_user)
        end

        def valid_enterprise!
          return unless current_enterprise.id != current_user.enterprise.id

          raise ActiveRecord::RecordNotFound,
                I18n.t('services.enterprises.update.not_found')
        end

        def current_enterprise
          @current_enterprise ||= Enterprise.find_by!(token: params[:token])
        end

        def allowed_params
          @allowed_params ||= params.require('enterprise').permit!
        end
      end
    end
  end
end
