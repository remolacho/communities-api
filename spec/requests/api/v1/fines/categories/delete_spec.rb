# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Fines::Categories::DeleteController do
  include_context 'list_categories_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }
  let(:id) { category_fine_root.id }

  path '/{enterprise_subdomain}/v1/fines/categories/delete/{id}' do
    delete 'Deactivate a fine category' do
      tags 'Community API V1 Fines'
      description 'Allow users to deactivate a fine category'
      produces 'application/json'
      consumes 'application/json'

      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'Subdomain of enterprise'
      parameter name: :id, in: :path, type: :string,
                description: 'ID of the category to deactivate'
      parameter name: :lang, in: :query, type: :string, description: 'Optional, default is "es"'

      response 200, 'success!!!' do
        let(:Authorization) do
          user_role_admin
          sign_in
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 message: { type: :string }
               }

        run_test!
      end

      response 403, 'error forbidden!!!' do
        let(:Authorization) do
          user_role_coexistence_member
          sign_in
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string },
                 data: { type: :object }
               }

        run_test!
      end

      response 404, 'error not found!!!' do
        let(:Authorization) do
          user_role_admin
          sign_in
        end

        let(:id) { 0 }

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
