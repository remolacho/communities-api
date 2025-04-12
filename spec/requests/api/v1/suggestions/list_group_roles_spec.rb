# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Suggestions::ListGroupRolesController, type: :request do
  include_context 'list_group_roles_suggestions_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/suggestion/list_group_roles' do
    get 'Request the list of suggestions with group roles' do
      tags 'Community API V1 Suggestions'
      description 'Allow to users get list of suggestion with group roles'
      produces 'application/json'
      consumes 'application/json'

      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
      parameter name: :read, in: :query, type: :integer, description: 'is optional represent the filter by read'
      parameter name: :anonymous, in: :query, type: :integer,
                description: 'is optional represent the filter by user anonymous'
      parameter name: :page, in: :query, type: :string, description: 'is optional represent the number page of find'

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
                           avatar_url: { type: :string, nullable: true }
                         }
                       }
                     }
                   }
                 },
                 paginate: {
                   type: :object,
                   properties: {
                     limit: { type: :integer },
                     total_pages: { type: :integer },
                     current_page: { type: :integer }
                   }
                 }
               }

        let(:anonymous) do
          user_role_manager
          group_listed_suggestions
          group_role_relations
          suggestions_anonymous
          true
        end

        let(:read) do
          suggestions
          suggestions_anonymous_readed
          suggestions_readed
          true
        end

        let(:page) { '1' }

        run_test!
      end

      response 403, 'error forbidden!!!' do
        let(:Authorization) { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:anonymous) do
          suggestions_anonymous
          nil
        end

        let(:read) do
          suggestions
          suggestions_anonymous_readed
          suggestions_readed
          true
        end

        let(:page) { '1' }

        run_test!
      end
    end
  end
end
