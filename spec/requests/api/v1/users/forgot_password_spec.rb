# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe  Api::V1::Users::ForgotPasswordController, type: :request do
  include_context 'sign_in_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/users/forgot_password' do
    post 'Create a new request for change password' do
      tags 'Community API V1 Users'
      description "Allow to users do change to password"
      produces 'application/json'
      consumes 'application/json'
      parameter name: :forgot_password, in: :body, schema: {
        type: :object,
        properties: {
          forgot_password:{
            type: :object,
            properties: {
              email: { type: :string },
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


        let(:forgot_password) {
          user_enterprise

          {
            forgot_password: { email: user.email }
          }
        }

        run_test! do |response|
          body = JSON.parse(response.body)
          expect(body['success']).to eq(true)
        end
      end

      response 422, 'error email is empty!!!' do
        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:forgot_password) {
          {
            forgot_password: { email: "" }
          }
        }

        run_test! do |response|
          body = JSON.parse(response.body)
          expect(body['success']).to eq(false)
        end
      end

      response 404, 'error user not found!!!' do
        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:forgot_password) {
          {
            forgot_password: { email: "test4@errornotfound.com" }
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
