# frozen_string_literal: true

module Api
  module V1
    module Petitions
      module Answers
        module Files
          class ListController < ApplicationController
            # GET /:enterprise_subdomain/v1/petition/answer/files/:id/list
            def list
              policy.can_read!

              service = ::AnswersPetitions::Files::ListService.new(enterprise: enterprise,
                                                                   user: current_user,
                                                                   answer: answer)

              render json: { success: true, data: service.call }
            end

            private

            def policy
              ::AnswersPetitions::Policy.new(current_user: current_user, petition: answer.petition)
            end

            def answer
              @answer ||= AnswersPetition.find(params[:id])
            end
          end
        end
      end
    end
  end
end
