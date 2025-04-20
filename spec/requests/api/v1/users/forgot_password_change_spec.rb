# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Users::ForgotPasswordController do
  include_context 'sign_in_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/users/forgot_password/change/{token}' do
    post 'Change password' do
      tags 'Community API V1 Users'
      description 'Allow to users do change to password'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :forgot_password, in: :body, schema: {
        type: :object,
        properties: {
          forgot_password: {
            type: :object,
            properties: {
              password: { type: :string },
              password_confirmation: { type: :string }
            }
          }
        }
      }
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
      parameter name: :token, in: :path, type: :string, description: 'this token represent the reset_password_key'

      response 200, 'success!!!' do
        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 message: { type: :string }
               }

        let(:token) do
          forgot = Users::ForgotPasswordService.new(email: user.email)
          forgot.call.reset_password_key
        end

        let(:forgot_password) do
          {
            password: '12345678',
            password_confirmation: '12345678'
          }
        end

        run_test!
      end

      response 422, 'error password not match!!!' do
        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:token) do
          forgot = Users::ForgotPasswordService.new(email: user.email)
          forgot.call.reset_password_key
        end

        let(:forgot_password) do
          {
            password: '12345',
            password_confirmation: '12345678'
          }
        end

        run_test!
      end
    end
  end
end
