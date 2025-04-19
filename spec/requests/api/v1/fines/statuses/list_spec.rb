# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Fines::Statuses::ListController do
  include_context 'legal_status_fines_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/fines/statuses/list/{token}' do
    get 'Find all available statuses for a fine' do
      tags 'Community API V1 Statuses Fine'
      description 'Allow users to find all available statuses according to fine type and current state'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'Subdomain of enterprise created in tenant creation'
      parameter name: :token, in: :path, type: :string, description: 'Token of the fine'
      parameter name: :lang, in: :query, type: :string, description: 'Optional language parameter, defaults to "es"'
      parameter name: 'Authorization', in: :header, required: true

      response 200, 'success lists' do
        let(:Authorization) { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       name: { type: :string },
                       code: { type: :string },
                       description: { type: :string }
                     }
                   }
                 }
               }

        let(:token) do
          user_role_admin
          fine.token
        end

        run_test!
      end

      response 403, 'error unauthorized access' do
        let(:Authorization) { '' }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:token) { fine.token }

        run_test!
      end

      response 404, 'error fine not found' do
        let(:Authorization) { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:token) { SecureRandom.uuid }

        run_test!
      end
    end
  end
end
