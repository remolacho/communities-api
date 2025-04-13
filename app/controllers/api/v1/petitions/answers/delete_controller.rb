# frozen_string_literal: true

module Api
  module V1
    module Petitions
      module Answers
        class DeleteController < ApplicationController
          # DELETE /:enterprise_subdomain/v1/petition/answer/delete/:id
          def destroy
            policy.can_destroy!

            ::AnswersPetitions::DeleteService.new(answer: answer, user: current_user).call

            render json: { success: true, message: I18n.t('services.answers_petitions.delete.success') }
          end

          private

          def answer
            @answer ||= AnswersPetition.find(params[:id])
          end

          def policy
            ::AnswersPetitions::Policy.new(current_user: current_user, petition: answer.petition)
          end
        end
      end
    end
  end
end
