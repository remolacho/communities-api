# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Users::ForgotPasswordController do
  include_context 'sign_in_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/users/forgot_password/verifier/{token}' do
    get 'Create a new request for verifier token to change password' do
      tags 'Community API V1 Users'
      description 'Allow to users verifier to change password'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :token, in: :path, type: :string, description: 'this token represent the reset_password_key'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'

      response 200, 'success!!!' do
        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 message: { type: :string },
                 data: {
                   type: :object,
                   properties: {
                     token: { type: :string }
                   }
                 }
               }

        let(:token) do
          forgot = Users::ForgotPasswordService.new(email: user.email)
          forgot.call.reset_password_key
        end

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
