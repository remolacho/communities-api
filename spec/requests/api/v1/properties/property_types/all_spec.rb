# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Properties::PropertyTypes::AllController do
  include_context 'property_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/properties/property_types/all' do
    get 'List all property types' do
      tags 'Community API V1 Properties'
      description 'Returns a list of active property types'
      produces 'application/json'

      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'Subdomain of enterprise'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'

      response 200, 'property types listed successfully' do
        let(:Authorization) { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       name: { type: :string },
                       active: { type: :boolean }
                     }
                   }
                 }
               },
               required: ['success', 'data']

        before do
          user_role_admin
          entity_permissions
        end

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
