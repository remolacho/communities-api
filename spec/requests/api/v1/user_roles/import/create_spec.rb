# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::UserRoles::Import::CreateController, type: :request do
  include_context 'user_roles_templates_import_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/user_roles/import/create' do
    post 'Allow to users create roles to users' do
      tags 'Community API V1 Users Roles'
      description "Allow to users create roles to users by xlsx"
      produces 'application/json'
      consumes 'multipart/form-data'
      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string, description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
      parameter name: :user_roles_file, in: :form, type: :file, description: 'the file import user roles'

      response 200, 'success, but It can finish with errors!!' do
        let(:'Authorization') {
          new_user
          group_role_relations_assign
          user_role_admin
          sign_in
        }

        let(:user_roles_file) {
          {
            user_roles_file: Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/6-finish.xlsx',
                                                     ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
          }
        }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 message: { type: :string },
                 errors: {
                   type: :array,
                   items: {
                     type: :string
                   }
                 }
               }

        xit ''
      end

      response 403, 'user not role admin or super admin!!!' do
        let(:'Authorization') {
          new_user
          group_role_relations_assign
          user_role_coexistence
          sign_in
        }

        let(:user_roles_file) {
          {
            user_roles_file: Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/6-finish.xlsx',
                                                     ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
          }
        }

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
