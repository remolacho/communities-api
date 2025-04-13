# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Petitions::Answers::Files::ListController do
  include_context 'create_answer_petition_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/petition/answer/files/{id}/list' do
    get 'Find all files of answer' do
      tags 'Community API V1 Answers petition'
      description 'Allow to users find all files of answer'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :id, in: :path, type: :integer, description: 'this identifier is the answer'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
      parameter name: 'Authorization', in: :header, required: true

      response 200, 'success!!!' do
        let(:Authorization) { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       name: { type: :string },
                       ext: { type: :string },
                       url: { type: :string }
                     }
                   }
                 }
               }

        let(:id) do
          user_enterprise_answer
          user_role_answer

          data = { message: 'test message 1' }
          service_answer = AnswersPetitions::CreateService.new(petition: petition, user: user_answer, data: data)
          answer = service_answer.call
          answer.id
        end

        run_test!
      end

      response 403, 'error role not allowed!!!' do
        let(:Authorization) { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:id) do
          user_enterprise_answer
          user_role_answer

          data = { message: 'test message 1' }

          service_answer = AnswersPetitions::CreateService.new(petition: petition_user_answer, user: user_answer,
                                                               data: data)
          answer = service_answer.call
          answer.id
        end

        run_test!
      end

      response 404, 'error answer not found!!!' do
        let(:Authorization) { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:id) { 999 }

        run_test!
      end
    end
  end
end
