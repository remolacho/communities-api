# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Fines::Categories::ListController do
  include_context 'list_categories_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/fines/categories/list' do
    get 'Request the list of fine categories' do
      tags 'Community API V1 Fines'
      description 'Allow users to get list of fine categories with their children'
      produces 'application/json'
      consumes 'application/json'

      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'Subdomain of enterprise'
      parameter name: :lang, in: :query, type: :string, description: 'Optional, default is "es"'
      parameter name: :page, in: :query, type: :string, description: 'Optional, represents the page number'

      response 200, 'success!!!' do
        let(:Authorization) { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 data: {
                   type: :array,
                   items: {
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
                 },
                 paginate: {
                   type: :object,
                   properties: {
                     limit: { type: :integer, description: 'Number of items per page' },
                     total_pages: { type: :integer, description: 'Total number of pages' },
                     current_page: { type: :integer, description: 'Current page number' }
                   }
                 }
               }

        let(:page) { '1' }

        before do
          user_role_admin
          entity_permissions
        end

        run_test!
      end

      response 403, 'error forbidden!!!' do
        let(:Authorization) { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:page) { '1' }

        before do
          user_role_coexistence_member
          entity_permissions
        end

        run_test!
      end
    end
  end
end
