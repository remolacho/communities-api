# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Suggestions::CreateController, type: :request do
  include_context 'create_suggestion_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/suggestion/create' do
    post 'Create a new suggestion' do
      tags 'Community API V1 Suggestions'
      description 'Allow to users create suggestions'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :suggestion, in: :body, schema: {
        type: :object,
        properties: {
          suggestion: {
            type: :object,
            properties: {
              message: { type: :string },
              anonymous: { type: :boolean, default: false },
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
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
      parameter name: 'Authorization', in: :header, required: true

      response 200, 'success!!!' do
        let(:Authorization) { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 data: { type: :object,
                         properties: {
                           ticket: { type: :string },
                           token: { type: :string }
                         } }
               }

        let(:suggestion) do
          {
            suggestion: {
              message: 'message test 1'
            }
          }
        end

        run_test!
      end

      response 403, 'error not logged!!!' do
        let(:Authorization) { '' }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:suggestion) do
          {
            suggestion: {
              message: 'message test 1'
            }
          }
        end

        run_test!
      end
    end
  end
end
