# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe  Api::V1::Users::SignInController, type: :request do
  include_context 'login_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/users/sign_in' do
    post 'Create login by user' do
      tags 'Community API V1 Users'
      description "Allow to users enter to api through of the email and password"
      produces 'application/json'
      consumes 'application/json'
      parameter name: :sign_in, in: :body, schema: {
        type: :object,
        properties: {
          sign_in:{
            type: :object,
            properties: {
              email: { type: :string },
              password: { type: :string }
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
                 data: {
                   type: :object,
                   properties: {
                     jwt: { type: :string }
                   }
                 }
               }


        let(:sign_in) {
          user_enterprise

          {
            sign_in: { email: user.email, password: user.password }
          }
        }

        run_test! do |response|
          body = JSON.parse(response.body)
          expect(body['success']).to eq(true)
          expect(body['data']['jwt'].present?).to eq(true)
        end
      end

      response 403, 'error password or user is not active!!!' do
        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:sign_in) {
          user_enterprise

          {
            sign_in: { email: user.email, password: 'errorTest' }
          }
        }

        run_test! do |response|
          body = JSON.parse(response.body)
          expect(body['success']).to eq(false)
        end
      end
    end
  end
end
