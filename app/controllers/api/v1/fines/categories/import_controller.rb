# frozen_string_literal: true

module Api
  module V1
    module Fines
      module Categories
        class ImportController < ApplicationController
          # POST /v1/fines/categories/import
          def create
            policy.can_write!

            service.call

            render json: { success: true, message: I18n.t('services.fines.categories.import.success') }
          end

          private

          def service
            @service ||= ::Fines::Categories::ImportService.new(
              user: current_user,
              file: allowed_params
            )
          end

          def policy
            @policy ||= ::CategoriesFines::Policy.new(current_user: current_user)
          end

          def allowed_params
            @allowed_params ||= params[:fines_categories_file]
          end
        end
      end
    end
  end
end
