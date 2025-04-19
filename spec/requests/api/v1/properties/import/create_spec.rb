# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Properties::Import::CreateController do
  include_context 'properties_import_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/properties/import/create' do
    post 'Import properties from XLSX file' do
      tags 'Community API V1 Properties Import'
      description 'Allow users to import properties from an XLSX file'
      produces 'application/json'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'Subdomain of enterprise'
      parameter name: :property_import_file, in: :formData, type: :file,
                required: true, description: 'XLSX file with properties to import'

      response 200, 'properties imported successfully' do
        let(:Authorization) { sign_in }
        let(:property_import_file) { success_file }

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

      response 403, 'error forbidden!!!' do
        let(:Authorization) { sign_in }
        let(:property_import_file) { success_file }

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

      response 404, 'error not found' do
        let(:Authorization) { sign_in }
        let(:property_import_file) { status_error_file }

        schema type: :object,
               properties: {
                 error: { type: :string }
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
