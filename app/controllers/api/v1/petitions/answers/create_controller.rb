# frozen_string_literal: true

module Api
  module V1
    module Petitions
      module Answers
        class CreateController < ApplicationController
          # POST /:enterprise_subdomain/v1/petition/answer/:token/create
          def create
            ::AnswersPetitions::CreateService.new(petition: petition, user: current_user, data: allowed_params).call

            render json: { success: true, message: I18n.t('services.answers_petitions.create.success') }
          end

          private

          def petition
            @petition ||= Petition.find_by!(token: params[:token])
          end

          def allowed_params
            @allowed_params ||= params.require(:answer).permit!
          end
        end
      end
    end
  end
end
