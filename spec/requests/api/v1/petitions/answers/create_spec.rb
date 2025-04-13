# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Petitions::Answers::CreateController do
  include_context 'create_answer_petition_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/petition/answer/{token}/create' do
    post 'Create a new answer for petition' do
      tags 'Community API V1 Answers petition'
      description 'Allow to users create answer in a petition'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :answer, in: :body, schema: {
        type: :object,
        properties: {
          answer: {
            type: :object,
            properties: {
              message: { type: :string },
              files: {
                type: :array,
                items: {
                  type: :string
                }
              }
            }
          }
        }
      }
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :token, in: :path, type: :string, description: 'this token is the petition information'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
      parameter name: 'Authorization', in: :header, required: true

      response 200, 'success!!!' do
        let(:Authorization) { sign_in }
        let(:token) { petition.token }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 message: { type: :string }
               }

        let(:answer) do
          {
            answer: {
              message: 'message test 1'
            }
          }
        end

        run_test!
      end

      response 404, 'error petition!!!' do
        let(:Authorization) { sign_in }
        let(:token) { SecureRandom.uuid }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:answer) do
          {
            answer: {
              message: 'message test 1'
            }
          }
        end

        run_test!
      end

      response 403, 'error not logged, not allowed role or the petition is resolved' do
        let(:Authorization) { '' }
        let(:token) { petition.token }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:answer) do
          {
            answer: {
              message: 'message test 1'
            }
          }
        end

        run_test!
      end
    end
  end
end
