# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Petitions::Statuses::UpdateStatusController, type: :request do
  include_context 'pending_status_petition_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/petition/statuses/update/{token}' do
    put 'Change status to petition' do
      tags 'Community API V1 Petitions'
      description 'Allow to users change of status in the petitions'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :petition_param, in: :body, schema: {
        type: :object,
        properties: {
          petition: {
            type: :object,
            properties: {
              status_id: { type: :integer }
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

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 message: { type: :string }
               }

        let(:token) do
          user_role

          petition.token
        end

        let(:petition_param) do
          {
            petition: {
              status_id: status_reviewing.id
            }
          }
        end

        run_test!
      end

      response 404, 'Error petition not found' do
        let(:Authorization) { sign_in }
        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:token) { SecureRandom.uuid }

        let(:petition_param) do
          {
            petition: {
              status_id: status_reviewing.id
            }
          }
        end

        run_test!
      end

      response 403, 'error change status allowed' do
        let(:Authorization) { sign_in }
        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:token) do
          user_role

          petition.token
        end

        let(:petition_param) do
          {
            petition: {
              status_id: status_confirm.id
            }
          }
        end

        run_test!
      end
    end
  end
end
