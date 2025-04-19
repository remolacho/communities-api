# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Properties::Statuses::AllController do
  include_context 'status_properties_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/properties/statuses/all' do
    get 'Find all statuses of type property' do
      tags 'Community API V1 Statuses property'
      description 'Allow to users find all statuses of type property'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
      parameter name: 'Authorization', in: :header, required: true

      response 200, 'success lists' do
        let(:Authorization) { sign_in }

        before do
          user_role_admin
          entity_permissions
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       as_name: { type: :string },
                       code: { type: :string },
                       color: { type: :string }
                     }
                   }
                 }
               }

        run_test!
      end

      response 403, 'forbidden access' do
        let(:Authorization) { sign_in }

        before do
          user_role_coexistence_member
          entity_permissions
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
