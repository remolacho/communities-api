# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Petitions::CreateController, type: :request do
  include_context 'create_petition_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/petition/create' do
    post 'Create a new petition' do
      tags 'Community API V1 Petitions'
      description 'Allow to users create petitions'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :petition, in: :body, schema: {
        type: :object,
        properties: {
          petition: {
            type: :object,
            properties: {
              title: { type: :string },
              message: { type: :string },
              category_petition_id: { type: :integer },
              group_role_id: { type: :integer },
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

        let(:petition) do
          {
            petition: {
              title: 'Test PQR',
              message: 'message test 1',
              category_petition_id: category.id,
              group_role_id: group_role.id
            }
          }
        end

        run_test! do |response|
          body = JSON.parse(response.body)
          expect(body['success']).to eq(true)
        end
      end

      response 404, 'error category, group_role not found!!!' do
        let(:Authorization) { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:petition) do
          {
            petition: {
              title: 'Test PQR',
              message: 'message test 1',
              category_petition_id: 9999,
              group_role_id: group_role.id
            }
          }
        end

        run_test! do |response|
          body = JSON.parse(response.body)
          expect(body['success']).to eq(false)
        end
      end

      response 403, 'error not logged!!!' do
        let(:Authorization) { '' }
        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:petition) do
          {
            petition: {
              title: 'Test PQR',
              message: 'message test 1',
              category_petition_id: category.id,
              group_role_id: group_role.id
            }
          }
        end

        run_test!
      end
    end
  end
end
