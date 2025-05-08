# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Petitions::Answers::DeleteController do
  include_context 'delete_answer_petition_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/petition/answer/delete/{id}' do
    delete 'Delete answer from petition' do
      tags 'Community API V1 Answers petition'
      description 'Allow users to delete their answers from a petition'
      produces 'application/json'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :id, in: :path, type: :string,
                description: 'this identifier unique of the answer'
      parameter name: :lang, in: :query, type: :string,
                description: 'is optional by default is "es"'

      response 200, 'success the user has can destroy the answer is not owner' do
        let(:Authorization) { sign_in }
        let(:id) do
          user_role_coexistence
          answer.id
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 message: { type: :string }
               }

        run_test!
      end

      response 403, 'error the user not logged !!!' do
        let(:Authorization) { sign_in }
        let(:id) do
          user_role_council
          answer.id
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        run_test!
      end

      response 404, 'error the answer not found !!!' do
        let(:Authorization) { sign_in }
        let(:id) { 1000 }

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
