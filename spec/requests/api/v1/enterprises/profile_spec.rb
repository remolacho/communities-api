# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Enterprises::ProfileController, type: :request do
  include_context 'enterprise_profile_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/enterprise/profile' do
    get 'Find the profile and data of current enterprise' do
      tags 'Community API V1 Enterprises'
      description "Find the profile and data of current enterprise"
      produces 'application/json'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string, description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'

      response 200, 'success!!!' do
        let(:'Authorization') {
          group_role_relations
          user_role_manager
          sign_in
        }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 data: { type: :object,
                         properties: {
                           id: {type: :integer},
                           rut: {type: :string},
                           email: {type: :string},
                           token: {type: :string},
                           name: {type: :string},
                           address: {type: :string, nullable: true },
                           subdomain: {type: :string},
                           logo_url: {type: :string, nullable: true },
                           banner_url: {type: :string, nullable: true },
                           reference_regex: {type: :string},
                           short_name: {type: :string},
                           active: {type: :boolean, default: true},
                           created_at: {type: :string},
                           updated_at: {type: :string}
                         }
                }
               }

        run_test!
      end

      response 403, 'error user not valid!!!' do
        let(:'Authorization') {
          group_role_relations
          sign_in
        }

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
