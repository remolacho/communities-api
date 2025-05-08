# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Properties::Import::TemplateController do
  include_context 'properties_import_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/properties/import/template' do
    get 'Download template for property import' do
      tags 'Community API V1 Properties Import'
      description 'Allow users to download the template for importing properties'
      produces 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      consumes 'application/json'

      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'Subdomain of enterprise'
      parameter name: :lang, in: :query, type: :string, description: 'Optional, default is "es"'

      response 200, 'template downloaded successfully' do
        let(:Authorization) { sign_in }

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

        before do
          user_role_coexistence_member
          entity_permissions
        end

        run_test!
      end
    end
  end
end
