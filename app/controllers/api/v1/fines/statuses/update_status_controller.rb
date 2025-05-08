# frozen_string_literal: true

module Api
  module V1
    module Fines
      module Statuses
        class UpdateStatusController < ApplicationController
          # PUT /:enterprise_subdomain/v1/fines/statuses/update/:token
          def update
            policy.can_write!

            ::Fines::UpdateStatusService.new(user: current_user, fine: fine, status: status).call

            render json: { success: true, message: I18n.t('services.fines.update_status.success') }
          end

          private

          def policy
            @policy ||= ::UpdateStatusFines::Policy.new(current_user: current_user,
                                                        fine: fine,
                                                        status: status)
          end

          def fine
            @fine ||= Fine.find_by!(token: params[:token])
          end

          def status
            Status.find(allowed_params[:status_id])
          end

          def allowed_params
            @allowed_params ||= params.require(:fine).permit(:status_id)
          end
        end
      end
    end
  end
end
