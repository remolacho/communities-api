# frozen_string_literal: true

module Api
  module V1
    module Users
      class ChangeStatusController < ApplicationController
        # GET /:enterprise_subdomain/v1/users/change_status/:token
        def show
          policy.can_write!

          ::Users::ChangeStatusAccount.new(user: current_user, user_to_change: user_to_change).call

          render json: { success: true, message: I18n.t('services.users.change_status.success') }
        end

        private

        def user_to_change
          @user_to_change ||= enterprise.users.find_by!(token: params[:token])
        end

        def policy
          ::Users::ChangeStatus::Policy.new(current_user: current_user, enterprise: enterprise)
        end
      end
    end
  end
end
