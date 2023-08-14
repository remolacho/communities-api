# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe  Api::V1::Petitions::ListOwnController, type: :request do
  include_context 'list_own_petitions_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/petition/list_own' do
    get 'Request the list of petitions own' do
      tags 'Community API V1 Petitions'
      description "Allow to users get your list of petition"
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
                           lastname: { type: :string },
                           avatar_url: {type: :string, nullable: true }
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
          complaints
          petitions
          status_resolved.id
        }

        let(:category_petition_id) {
          category_complaint.id
        }

        let(:page) { "1" }

        run_test!
      end

      response 403, 'error the user not logged!!!' do
        let(:'Authorization') { '' }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:status_id) { "reference" }
        let(:category_petition_id) { "T4" }
        let(:page) { "1" }

        run_test!
      end
    end
  end
end
