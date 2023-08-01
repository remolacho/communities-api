require 'swagger_helper'

RSpec.describe Api::V1::Petitions::Answers::DeleteController, type: :request do
  include_context 'delete_answer_petition_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/petition/answer/delete/{id}' do
    delete 'Delete a answer for petition' do
      tags 'Community API V1 Answers petition'
      description "Allow to users create answer in a petition"
      produces 'application/json'
      consumes 'application/json'
      parameter name: :enterprise_subdomain, in: :path, type: :string, description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :id, in: :path, type: :string, description: 'this identifier unique of the answer'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
      parameter name: 'Authorization', in: :header, required: true

      response 200, 'success!!!' do
        let(:'Authorization') { sign_in }
        let(:id) { answer.id }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 message: { type: :string}
               }

        run_test!
      end

      response 403, 'error the user not logged !!!' do
        let(:'Authorization') { "" }
        let(:id) { answer.id }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string}
               }

        run_test!
      end

      response 404, 'error the answer not belong to user logged !!!' do
        let(:'Authorization') { sign_in }
        let(:id) { answer2.id }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string}
               }

        run_test!
      end
    end
  end
end
