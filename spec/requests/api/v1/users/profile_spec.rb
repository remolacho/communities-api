# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe  Api::V1::Users::ProfileController, type: :request do
  include_context 'sign_in_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/users/profile/show' do
    get 'Find the profile of current user' do
      tags 'Community API V1 Users'
      description "Allow see the user's data logged"
      produces 'application/json'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string, description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'

      response 200, 'success!!!' do
        let(:'Authorization') { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 data: { type: :object,
                         properties: {
                           id: {type: :integer},
                           name: {type: :string},
                           lastname: {type: :string},
                           email: {type: :string},
                           reference: {type: :string, nullable: true},
                           identifier: {type: :string},
                           phone: {type: :string, nullable: true },
                           avatar_url: {type: :string, nullable: true }
                         }
                }
               }

        run_test! do |response|
          body = JSON.parse(response.body)
          expect(body['success']).to eq(true)
        end
      end

      response 403, 'error user not valid!!!' do
        let(:'Authorization') { "" }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        run_test!
      end
    end
  end
end
