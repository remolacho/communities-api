# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Petitions::Statuses::ListController, type: :request do
  include_context 'pending_status_petition_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/petition/statuses/list/{token}' do
    get 'Find all statuses of one petition' do
      tags 'Community API V1 Statuses petition'
      description 'Allow to users find all statuses according to petition through your state'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :token, in: :path, type: :string, description: 'this token is the petition information'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
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
                       color: { type: :string }
                     }
                   }
                 }
               }

        let(:token) do
          user_role
          petition.token
        end

        run_test!
      end

      response 403, 'error user logged!' do
        let(:Authorization) { '' }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:token) { petition.token }

        run_test!
      end

      response 404, 'error petition not found!!!' do
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
