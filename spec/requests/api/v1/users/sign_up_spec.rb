# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe  Api::V1::Users::SignInController, type: :request do
  include_context 'sign_up_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/users/sign_up' do
    post 'Create user' do
      tags 'Community API V1 Users'
      description "Allow create a account in the app"
      produces 'application/json'
      consumes 'application/json'
      parameter name: :sign_up, in: :body, schema: {
        type: :object,
        properties: {
          sign_up:{
            type: :object,
            properties: {
              name: { type: :string },
              lastname: { type: :string },
              identifier: { type: :string },
              email: { type: :string },
              phone: { type: :string },
              reference: { type: :string },
              password: { type: :string },
              password_confirmation: { type: :string }
            }
          }
        }
      }
      parameter name: :enterprise_subdomain, in: :path, type: :string, description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'

      response 200, 'success!!!' do
        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 message: { type: :string }
               }

        let(:sign_up) {
          enterprise
          { sign_up: allowed_params }
        }

        run_test!
      end

      response 404, 'error email empty and other attribute!!!' do
        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:sign_up) {
          enterprise
          data = allowed_params
          data[:password] = ""

          { sign_up: data }
        }

        run_test!
      end

      response 422, 'error user already exists identifier duplicate!!!' do
        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:sign_up) {
          enterprise
          user_enterprise
          data = allowed_params
          data[:identifier] = user.identifier

          { sign_up: data }
        }

        run_test!
      end
    end
  end
end
