# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Petitions::Files::ListController do
  include_context 'detail_petition_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/petition/files/{token}/list' do
    get 'Find all files of petition' do
      tags 'Community API V1 Petitions'
      description 'Allow to users find all files of petitions'
      produces 'application/json'
      consumes 'application/json'

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

        let(:token) do
          user_role
          petition.token
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

        let(:token) do
          user_role_coexistence_member
          petition.token
        end

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
