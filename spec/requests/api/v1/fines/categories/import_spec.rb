# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Fines::Categories::ImportController do
  include_context 'import_categories_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/fines/categories/import' do
    post 'Import fine categories from Excel file' do
      tags 'Community API V1 Fines'
      description 'Allow users to import fine categories from an Excel file'
      produces 'application/json'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'Subdomain of enterprise'
      parameter name: :lang, in: :query, type: :string, description: 'Optional, default is "es"'
      parameter name: :fines_categories_file, in: :formData, type: :file,
                required: true, description: 'Excel file with categories data'

      response 200, 'success!!!' do
        let(:Authorization) { sign_in }
        let(:fines_categories_file) { success_file }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 message: { type: :string }
               }

        before do
          user_role_admin
          entity_permissions
        end

        run_test!
      end

      response 422, 'error invalid file!!!' do
        let(:Authorization) { sign_in }
        let(:fines_categories_file) { nil }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        before do
          user_role_admin
          entity_permissions
        end

        run_test!
      end

      response 422, 'error invalid header!!!' do
        let(:Authorization) { sign_in }
        let(:fines_categories_file) { error_header_file }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        before do
          user_role_admin
          entity_permissions
        end

        run_test!
      end

      response 403, 'error forbidden!!!' do
        let(:Authorization) { sign_in }
        let(:fines_categories_file) { success_file }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string },
                 data: { type: :object }
               }

        before do
          user_role_coexistence_member
          entity_permissions
        end

        run_test!
      end
    end
  end
end
