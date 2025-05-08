# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::UserProperties::Import::CreateController do
  include_context 'user_properties_import_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/user_properties/import/create' do
    post 'Import user properties from XLSX file' do
      tags 'Community API V1 User Properties Import'
      description 'Allow users to import user properties from an XLSX file'
      produces 'application/json'
      consumes 'multipart/form-data'

      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'Subdomain of enterprise'
      parameter name: :user_properties_file, in: :formData, type: :file,
                required: true, description: 'XLSX file with user properties to import'

      response 200, 'user properties imported successfully' do
        let(:Authorization) { sign_in }
        let(:user_properties_file) { template_success }

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

      response 422, 'invalid header format' do
        let(:Authorization) { sign_in }
        let(:user_properties_file) { template_header_error }

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

      response 404, 'user not found' do
        let(:Authorization) { sign_in }
        let(:user_properties_file) { template_user_error }

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

      response 403, 'forbidden access' do
        let(:Authorization) { sign_in }
        let(:user_properties_file) { template_success }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        before do
          user_role_admin
          entity_permissions.update!(can_write: false)
        end

        run_test!
      end
    end
  end
end
