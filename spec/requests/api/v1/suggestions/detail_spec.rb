# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Suggestions::DetailController do
  include_context 'detail_suggestion_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/suggestion/detail/{token}' do
    get 'Find the detail of suggestion' do
      tags 'Community API V1 Suggestions'
      description 'Allow to users find suggestion and your detail'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :token, in: :path, type: :string, description: 'this token is the suggestion information'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
      parameter name: 'Authorization', in: :header, required: true

      response 200, 'success!!!' do
        let(:Authorization) { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     ticket: { type: :string },
                     token: { type: :string },
                     message: { type: :string },
                     read: { type: :boolean, default: false },
                     anonymous: { type: :boolean, default: false },
                     user: {
                       type: :object,
                       properties: {
                         id: { type: :integer },
                         name: { type: :string },
                         lastname: { type: :string },
                         avatar_url: { type: :string, nullable: true }
                       }
                     }
                   }
                 }
               }

        let(:token) do
          entity_permissions
          user_role_admin
          suggestion.token
        end

        run_test!
      end

      response 403, 'error role not allowed!!!' do
        let(:Authorization) { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:token) do
          entity_permissions
          user_role_manager
          suggestion.token
        end

        run_test!
      end

      response 404, 'error suggestion not found!!!' do
        let(:Authorization) { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:token) do
          entity_permissions
          user_role_admin
          SecureRandom.uuid
        end

        run_test!
      end
    end
  end
end
