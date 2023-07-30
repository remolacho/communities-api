# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe  Api::V1::Users::SignUpController , type: :request do
  include_context 'sign_up_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/users/sign_up/active/{token}' do
    get 'Request activation account' do
      tags 'Community API V1 Users'
      description "Allow to users activate account"
      produces 'application/json'
      consumes 'application/json'

      parameter name: :enterprise_subdomain, in: :path, type: :string, description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :token, in: :path, type: :string, description: 'this token represent the active_key'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'

      response 200, 'success!!!' do
        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 message: { type: :string },
               }

        let(:token) {
          user_sign_up = ::Users::SignUpService.new(enterprise: enterprise, data: allowed_params).call
          user_sign_up.active_key
        }

        run_test!
      end

      response 404, 'error token not valid!!!' do
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
