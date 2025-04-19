# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Properties::ListController do
  include_context 'property_list_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/properties/list' do
    get 'List all properties' do
      tags 'Community API V1 Properties'
      description 'Returns a list of properties'
      produces 'application/json'

      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'Subdomain of enterprise'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
      parameter name: :search_attr, in: :query, type: :string, description: 'is optional represent the field of find'
      parameter name: :term, in: :query, type: :string, description: 'is optional represent the value of find'
      parameter name: :status_id, in: :query, type: :string, description: 'is optional represent the value of find'
      parameter name: :property_type_id, in: :query, type: :string,
                description: 'is optional represent the value of find'
      parameter name: :page, in: :query, type: :string, description: 'is optional represent the number page of find'

      response 200, 'properties listed successfully' do
        let(:Authorization) { sign_in }
        let(:search_attr) { 'location' }
        let(:term) { 'T1-P1' }
        let(:property_type_id) { apartment_type.id }
        let(:status_id) { status.id }
        let(:page) { 1 }

        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       location: { type: :string },
                       active: { type: :boolean },
                       enterprise_id: { type: :integer },
                       property_type_id: { type: :integer },
                       status_id: { type: :integer },
                       property_type_name: { type: :string },
                       status_name: { type: :string }
                     }
                   }
                 },
                 paginate: {
                   type: :object,
                   properties: {
                     limit: { type: :integer },
                     total_pages: { type: :integer },
                     current_page: { type: :integer }
                   }
                 }
               },
               required: ['success', 'data', 'paginate']

        before do
          user_role_admin
          entity_permissions
        end

        run_test!
      end

      response 403, 'forbidden access' do
        let(:Authorization) { sign_in }
        let(:search_attr) { '' }
        let(:term) { '' }
        let(:property_type_id) { '' }
        let(:status_id) { '' }
        let(:page) { '' }

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
