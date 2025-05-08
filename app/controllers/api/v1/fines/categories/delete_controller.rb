# frozen_string_literal: true

module Api
  module V1
    module Fines
      module Categories
        class DeleteController < ApplicationController
          # DELETE /v1/fines/categories/delete/:id
          def destroy
            policy.can_destroy!

            service.call

            render json: { success: true, message: I18n.t('services.fines.categories.delete.success') }
          end

          private

          def service
            @service ||= ::Fines::Categories::DeactivateService.new(
              user: current_user,
              category: category
            )
          end

          def category
            @category ||= current_user.enterprise.category_fines.find(params[:id])
          end

          def policy
            @policy ||= ::CategoriesFines::Policy.new(current_user: current_user)
          end
        end
      end
    end
  end
end
