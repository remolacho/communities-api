# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Users::ChangeStatusController, type: :request do
  include_context 'change_status_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/users/change_status/{token}' do
    get 'Can change status active or inactive of the user' do
      tags 'Community API V1 Users'
      description "Allow a user activate or inactivate other user, the current user should have nay the roles [admin, super admin]"
      produces 'application/json'
      consumes 'application/json'

      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string, description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :token, in: :path, type: :string, description: 'the user token to change status'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'

      response 200, 'success!!!' do
        let(:'Authorization') {
          group_role_relations
          user_role_admin
          sign_in
        }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 message: { type: :string }
               }

        let(:token) {
          user_enterprise_to_change
          user_to_change.token
        }

        run_test!
      end

      response 403, 'error the user has not role!!!' do
        let(:'Authorization') { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:token) {
          group_role_relations
          user_enterprise_to_change
          user_to_change.token
        }

        run_test!
      end

      response 404, 'error the user token!!!' do
        let(:'Authorization') {
          group_role_relations
          user_role_admin
          sign_in
        }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }


        let(:token) {
          user_enterprise_to_change
          SecureRandom.uuid
        }

        run_test!
      end
    end
  end
end
