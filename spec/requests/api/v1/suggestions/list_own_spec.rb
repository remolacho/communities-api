# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe  Api::V1::Suggestions::ListOwnController, type: :request do
  include_context 'list_own_suggestions_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/suggestion/list_own' do
    get 'Request the list of suggestions own' do
      tags 'Community API V1 Suggestions'
      description "Allow to users get your list of suggestions"
      produces 'application/json'
      consumes 'application/json'

      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string, description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
      parameter name: :read, in: :query, type: :integer, description: 'is optional represent the filter by read'
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
                       token: { type: :string },
                       title: { type: :string },
                       message: { type: :string },
                       read: { type: :boolean },
                       anonymous: { type: :boolean },
                       user: {
                         type: :object,
                         properties: {
                           id: { type: :integer, nullable: true },
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

        let(:page) {
          suggestions_anonymous_readed
          suggestions
          "1"
        }

        let(:read) { }

        run_test!
      end

      response 403, 'error the user not logged!!!' do
        let(:'Authorization') { '' }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:read) {}
        let(:page) { "1" }

        run_test!
      end
    end
  end
end
