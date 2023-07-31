# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe  Api::V1::Petitions::ListGroupRolesController, type: :request do
  include_context 'list_group_roles_petitions_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/petition/list_group_roles' do
    get 'Request the list of petitions with group roles' do
      tags 'Community API V1 Petitions'
      description "Allow to users get list of petition with group roles"
      produces 'application/json'
      consumes 'application/json'

      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string, description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
      parameter name: :status_id, in: :query, type: :integer, description: 'is optional represent the filter by status'
      parameter name: :category_petition_id, in: :query, type: :integer, description: 'is optional represent the filter by category'
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
                       id: { type: :integer },
                       ticket: { type: :string },
                       token: { type: :string },
                       title: { type: :string },
                       message: { type: :string },
                       status: {
                         type: :object,
                         properties: {
                           id: { type: :integer },
                           name: { type: :string },
                           code: { type: :string },
                           color: { type: :string }
                         }
                       },
                       category: {
                         type: :object,
                         properties: {
                           id: { type: :integer },
                           name: { type: :string }
                         }
                       },
                       group_role: {
                         type: :object,
                         properties: {
                           id: { type: :integer },
                           name: { type: :string },
                         }
                       },
                       user: {
                         type: :object,
                         properties: {
                           id: { type: :integer },
                           name: { type: :string },
                           lastname: { type: :string }
                         }
                       }
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

        let(:status_id) {
          user_role_owner_admin
          user_role_admin
          group_role_admin
          user_role_committee_member

          claims
          petitions
          complaints
          status_resolved.id
        }

        let(:category_petition_id) {
          category_claim.id
        }

        let(:page) { "1" }

        run_test!
      end

      response 403, 'error forbidden!!!' do
        let(:'Authorization') { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:status_id) {
          user_role_owner_admin
          group_role_coexistence_committee
          ""
        }

        let(:category_petition_id) { "" }
        let(:page) { "" }

        run_test!
      end
    end
  end
end
