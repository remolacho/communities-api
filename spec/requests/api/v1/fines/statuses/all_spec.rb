# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Fines::Statuses::AllController do
  include_context 'status_fines_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/fines/statuses/all/{type}' do
    get 'Find all statuses of fines by type' do
      tags 'Community API V1 Statuses Fines'
      description 'Allow users to find all statuses of fines by type (legal or warning)'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'Subdomain of enterprise'
      parameter name: :type, in: :path, type: :string,
                description: 'Type of fine status (legal or warning)',
                enum: ['legal', 'warning']
      parameter name: :lang, in: :query, type: :string,
                description: 'Optional, default is "es"'
      parameter name: 'Authorization', in: :header, required: true

      response 200, 'success lists' do
        let(:Authorization) { sign_in }
        let(:type) { 'legal' }

        before do
          user_role_admin
          entity_permissions
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       as_name: { type: :string },
                       code: { type: :string },
                       color: { type: :string }
                     }
                   }
                 }
               }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['data'].length).to eq(5)
        end

        context 'when type is warning' do
          let(:type) { 'warning' }

          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['data'].length).to eq(3)
          end
        end
      end

      response 403, 'forbidden access' do
        let(:Authorization) { sign_in }
        let(:type) { 'legal' }

        before do
          user_role_coexistence_member
          entity_permissions
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        run_test!
      end

      response 423, 'invalid type' do
        let(:Authorization) { sign_in }
        let(:type) { 'invalid' }

        before do
          user_role_admin
          entity_permissions
        end

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
