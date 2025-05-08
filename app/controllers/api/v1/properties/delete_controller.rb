# frozen_string_literal: true

module Api
  module V1
    module Properties
      # DELETE /api/v1/properties/delete/:id
      class DeleteController < ApplicationController
        def destroy
          policy.can_destroy!

          property.update!(active: !property.active)

          render json: {
            success: true,
            message: I18n.t('services.properties.delete.success')
          }
        end

        private

        def property
          @property ||= Property.find(params[:id])
        end

        def policy
          @policy ||= ::Properties::Policy.new(current_user: current_user)
        end
      end
    end
  end
end
