# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::GroupRoles::ListPetitionsController, type: :request do
  include_context 'group_roles_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/group_roles/list_petitions' do
    get 'List of group of roles by petitions entity' do
      tags 'Community API V1 Group Roles'
      description 'Allow to users get group of roles by petitions entity'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
      parameter name: 'Authorization', in: :header, required: true

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
                       name: { type: :string }
                     }
                   }
                 }
               }

        run_test!
      end

      response 403, 'error not logged!!!' do
        let(:Authorization) { '' }

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
