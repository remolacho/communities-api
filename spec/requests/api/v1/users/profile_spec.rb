# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Users::ProfileController do
  include_context 'user_profile_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/users/profile/show' do
    get 'Find the profile of current user' do
      tags 'Community API V1 Users'
      description "Allow see the user's data logged"
      produces 'application/json'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :token, in: :query, type: :string, description: 'is optional, the token of user'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'

      response 200, 'success user admin, manager!!!' do
        let(:Authorization) { sign_in }
        let(:token) { '' }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 data: { type: :object,
                         properties: {
                           id: { type: :integer },
                           token: { type: :string },
                           name: { type: :string },
                           lastname: { type: :string },
                           email: { type: :string },
                           reference: { type: :string, nullable: true },
                           identifier: { type: :string },
                           phone: { type: :string, nullable: true },
                           avatar_url: { type: :string, nullable: true },
                           setting: {
                             type: :object,
                             properties: {
                               can_edit: { type: :boolean, default: true }
                             }
                           }
                         } }
               }

        run_test!
      end

      response 200, 'success other user!!!' do
        let(:Authorization) { sign_in }
        let(:token) do
          group_role_relations
          user_role_admin
          user_other.token
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 data: { type: :object,
                         properties: {
                           id: { type: :integer },
                           name: { type: :string },
                           lastname: { type: :string },
                           email: { type: :string },
                           reference: { type: :string, nullable: true },
                           identifier: { type: :string },
                           phone: { type: :string, nullable: true },
                           avatar_url: { type: :string, nullable: true }
                         } }
               }

        run_test!
      end

      response 404, 'user token not found !!!' do
        let(:Authorization) { sign_in }
        let(:token) { SecureRandom.uuid }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        run_test!
      end

      response 403, 'error user not valid!!!' do
        let(:Authorization) { sign_in }
        let(:token) do
          group_role_relations
          user_other.token
        end

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
