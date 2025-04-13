# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Petitions::Answers::ListController do
  include_context 'list_answers_petition_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/petition/answers/list/{token}' do
    get 'Find all answers of one petition' do
      tags 'Community API V1 Answers petition'
      description 'Allow to users find all answers of the petition'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :token, in: :path, type: :string, description: 'this token is the petition information'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
      parameter name: 'Authorization', in: :header, required: true

      response 200, 'success lists' do
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
                       message: { type: :string },
                       date_at: { type: :string },
                       user: {
                         type: :object,
                         properties: {
                           id: { type: :integer },
                           name: { type: :string },
                           lastname: { type: :string },
                           avatar_url: { type: :string, nullable: true }
                         }
                       },
                       files: {
                         type: :array,
                         items: {
                           type: :object,
                           properties: {
                             name: { type: :string },
                             ext: { type: :string },
                             url: { type: :string, nullable: true }
                           }
                         }
                       },
                       setting: {
                         type: :object,
                         properties: {
                           delete: {
                             type: :object,
                             properties: {
                               action: { type: :boolean, default: true },
                               description: { type: :string }
                             }
                           }
                         }
                       }
                     }
                   }
                 }
               }

        let(:token) do
          entity_permissions
          user_role
          answer
          answer2
          petition.token
        end

        run_test!
      end

      response 403, 'error role not allowed!!!' do
        let(:Authorization) { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:token) { petition.token }

        run_test!
      end

      response 404, 'error petition not found!!!' do
        let(:Authorization) { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:token) { SecureRandom.uuid }

        run_test!
      end
    end
  end
end
