# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Properties::CreateController do
  include_context 'property_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/properties/create' do
    post 'Create a new property' do
      tags 'Community API V1 Properties'
      description 'Creates a new property with the given parameters'
      produces 'application/json'
      consumes 'application/json'

      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'Subdomain of enterprise'
      parameter name: :property, in: :body, schema: {
        type: :object,
        properties: {
          property: {
            type: :object,
            properties: {
              property_type_id: { type: :integer },
              location: { type: :string },
              status_id: { type: :integer }
            },
            required: ['property_type_id', 'location', 'status_id']
          }
        }
      }

      response 200, 'property created successfully' do
        let(:Authorization) { sign_in }
        let(:property) do
          {
            property: {
              property_type_id: apartment_type.id,
              location: valid_apartment_locations.first,
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

        run_test!
      end

      response 403, 'forbidden access' do
        let(:Authorization) { sign_in }
        let(:property) do
          {
            property: {
              property_type_id: apartment_type.id,
              location: valid_apartment_locations.first,
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

      response 404, 'property type not found' do
        let(:Authorization) { sign_in }
        let(:property) do
          {
            property: {
              property_type_id: 999,
              location: valid_apartment_locations.first,
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

      response 422, 'invalid location format' do
        let(:Authorization) { sign_in }
        let(:property) do
          {
            property: {
              property_type_id: apartment_type.id,
              location: invalid_apartment_locations.first,
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
