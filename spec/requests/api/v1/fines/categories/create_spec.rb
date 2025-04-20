# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Fines::Categories::CreateController do
  include_context 'create_category_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/fines/categories/create' do
    post 'Create a new fine category' do
      tags 'Community API V1 Fines'
      description 'Allow users to create a new fine category, optionally as a child of an existing category'
      produces 'application/json'
      consumes 'application/json'

      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'Subdomain of enterprise'
      parameter name: :lang, in: :query, type: :string, description: 'Optional, default is "es"'
      parameter name: :category_fine, in: :body, schema: {
        type: :object,
        properties: {
          category_fine: {
            type: :object,
            properties: {
              name: { type: :string, description: 'Name of the category' },
              code: { type: :string, description: 'Unique code for the category' },
              description: { type: :string, description: 'Optional description' },
              formula: { type: :string, description: 'Optional formula for calculation' },
              value: { type: :number, description: 'Optional base value' },
              parent_category_fine_id: { type: :integer, description: 'Optional ID of parent category',
                                         nullable: true },
              active: { type: :boolean, description: 'Optional status, defaults to true' }
            },
            required: ['name', 'code']
          }
        }
      }

      response 200, 'success!!!' do
        let(:Authorization) { sign_in }
        let(:category_fine) { { category_fine: valid_attributes } }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 data: {
                   type: :object,
                   properties: {
                     id: { type: :integer },
                     name: { type: :string },
                     description: { type: :string },
                     code: { type: :string },
                     formula: { type: :string },
                     value: { type: :number },
                     active: { type: :boolean },
                     parent_category_fine_id: { type: :integer, nullable: true }
                   }
                 }
               }

        before do
          user_role_admin
          entity_permissions
        end

        run_test!
      end

      response 403, 'error forbidden!!!' do
        let(:Authorization) { sign_in }
        let(:category_fine) { { category_fine: valid_attributes } }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        before do
          user_role_coexistence_member
          entity_permissions
        end

        run_test!
      end

      response 422, 'error unprocessable entity!!!' do
        let(:Authorization) { sign_in }
        let(:category_fine) { { category_fine: invalid_attributes } }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string },
                 errors: {
                   type: :object,
                   properties: {
                     name: { type: :array, items: { type: :string } },
                     code: { type: :array, items: { type: :string } }
                   }
                 }
               }

        before do
          user_role_admin
          entity_permissions
        end

        run_test!
      end
    end
  end
end
