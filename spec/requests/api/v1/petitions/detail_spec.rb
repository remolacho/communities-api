# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe  Api::V1::Petitions::DetailController, type: :request do
  include_context 'detail_petition_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/petition/detail/{token}' do
    get 'Find the detail of petition' do
      tags 'Community API V1 Petitions'
      description "Allow to users find petition and your detail"
      produces 'application/json'
      consumes 'application/json'

      parameter name: :enterprise_subdomain, in: :path, type: :string, description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :token, in: :path, type: :string, description: 'this token is the petition information'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
      parameter name: 'Authorization', in: :header, required: true

      response 200, 'success!!!' do
        let(:'Authorization') { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     ticket: { type: :string },
                     token: { type: :string },
                     title: { type: :string },
                     message: { type: :string },
                     status: {
                       type: :object,
                       properties: {
                         id: { type: :integer },
                         name: { type: :string },
                         code: { type: :string },
                         color: { type: :string }
                       }
                     },
                     category: {
                       type: :object,
                       properties: {
                         id: { type: :integer },
                         name: { type: :string }
                       }
                     },
                     group_role: {
                       type: :object,
                       properties: {
                         id: { type: :integer },
                         name: { type: :string },
                       }
                     },
                     user: {
                       type: :object,
                       properties: {
                         id: { type: :integer },
                         name: { type: :string },
                         lastname: { type: :string },
                         avatar_url: {type: :string, nullable: true}
                       }
                     }
                   }
                 }
               }

        let(:token) {
          user_role
          petition.token
        }

        run_test!
      end

      response 403, 'error role not allowed!!!' do
        let(:'Authorization') { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:token) { petition.token }

        run_test!
      end

      response 404, 'error petition not found!!!' do
        let(:'Authorization') { sign_in }

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
