# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::UserRoles::Templates::ImportController, type: :request do
  include_context 'user_roles_templates_import_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/user_roles/templates/import' do
    get 'Allow to users download a tempelate for importer the user roles' do
      tags 'Community API V1 Users Roles'
      description 'Allow to users download a tempelate for importer the user roles'
      consumes 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'

      response 200, 'success down laod file!!!' do
        xit ''
      end
    end
  end
end
