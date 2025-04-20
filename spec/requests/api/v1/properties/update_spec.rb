# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Properties::UpdateController do
  include_context 'property_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  let(:existing_property) do
    FactoryBot.create(:property,
           enterprise: enterprise,
           property_type: apartment_type,
           location: valid_apartment_locations.first,
           status: status)
  end

  path '/{enterprise_subdomain}/v1/properties/update/{id}' do
    put 'Update an existing property' do
      tags 'Community API V1 Properties'
      description 'Updates an existing property with the given parameters'
      produces 'application/json'
      consumes 'application/json'

      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'Subdomain of enterprise'
      parameter name: :id, in: :path, type: :integer,
                description: 'ID of the property to update'
      parameter name: :property, in: :body, schema: {
        type: :object,
        properties: {
          property: {
            type: :object,
            properties: {
              property_type_id: { type: :integer },
              location: { type: :string },
              status_id: { type: :integer }
            }
          }
        }
      }

      response 200, 'property updated successfully' do
        let(:Authorization) { sign_in }
        let(:id) { existing_property.id }
        let(:property) do
          {
            property: {
              property_type_id: apartment_type.id,
              location: valid_apartment_locations.last,
              status_id: status.id
            }
          }
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 property: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     location: { type: :string },
                     active: { type: :boolean },
                     enterprise_id: { type: :integer },
                     property_type_id: { type: :integer },
                     status_id: { type: :integer }
                   },
                   required: ['id', 'location', 'active', 'enterprise_id', 'property_type_id', 'status_id']
                 }
               },
               required: ['success', 'property']

        before do
          user_role_admin
          entity_permissions
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['success']).to eq(true)
          expect(data['property']['location']).to eq(valid_apartment_locations.last)
        end
      end

      response 403, 'forbidden - insufficient permissions' do
        let(:Authorization) { sign_in }
        let(:id) { existing_property.id }
        let(:property) do
          {
            property: {
              property_type_id: apartment_type.id,
              location: valid_apartment_locations.last,
              status_id: status.id
            }
          }
        end

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

      response 404, 'property not found' do
        let(:Authorization) { sign_in }
        let(:id) { 999 }
        let(:property) do
          {
            property: {
              property_type_id: apartment_type.id,
              location: valid_apartment_locations.last,
              status_id: status.id
            }
          }
        end

        before do
          user_role_admin
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
