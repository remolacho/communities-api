# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe  Api::V1::Users::ListController, type: :request do
  include_context 'list_users_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/users/list' do
    get 'Request the user list only roles [admin, super admin, manager]' do
      tags 'Community API V1 Users'
      description "Allow to users get 1 list of users, the current user should have nay the roles [admin, super admin, manager]"
      produces 'application/json'
      consumes 'application/json'

      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string, description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
      parameter name: :attr, in: :query, type: :string, description: 'is optional represent the field of find'
      parameter name: :term, in: :query, type: :string, description: 'is optional represent the value of find'
      parameter name: :page, in: :query, type: :string, description: 'is optional represent the number page of find'

      response 200, 'success!!!' do
        let(:'Authorization') { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 data: {
                   type: :array,
                   items:{
                     type: :object,
                     properties: {
                       id: {type: :integer},
                       name: {type: :string},
                       lastname: {type: :string},
                       email: {type: :string},
                       reference: {type: :string, nullable: true},
                       identifier: {type: :string},
                       phone: {type: :string, nullable: true }
                     }
                   }
                 },
                 paginate: {
                   type: :object,
                   properties: {
                     limit: {type: :integer},
                     total_pages: {type: :integer},
                     current_page: {type: :integer},
                   }
                 }
               }

        let(:attr) { "reference" }
        let(:term) { "T4" }
        let(:page) { "1" }

        run_test!
      end

      response 403, 'error the user has not role!!!' do
        let(:'Authorization') { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:attr) { "" }
        let(:term) {
          user.user_roles.find_by(role_id: role_manager.id).delete
          ""
        }
        let(:page) { "1" }


        run_test!
      end
    end
  end
end
