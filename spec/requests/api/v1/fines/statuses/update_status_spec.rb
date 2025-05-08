# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Fines::Statuses::UpdateStatusController do
  include_context 'legal_status_fines_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/fines/statuses/update/{token}' do
    put 'Change status of a fine' do
      tags 'Community API V1 Fines'
      description 'Allow users to change the status of fines'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :fine_param, in: :body, schema: {
        type: :object,
        properties: {
          fine: {
            type: :object,
            properties: {
              status_id: { type: :integer }
            }
          }
        }
      }
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'Subdomain of enterprise created in tenant creation'
      parameter name: :token, in: :path, type: :string, description: 'Token of the fine to update'
      parameter name: :lang, in: :query, type: :string, description: 'Optional language parameter, defaults to "es"'
      parameter name: 'Authorization', in: :header, required: true

      response 200, 'Status updated successfully' do
        let(:Authorization) { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 message: { type: :string }
               }

        let(:token) do
          user_role_admin
          fine.token
        end

        let(:fine_param) do
          {
            fine: {
              status_id: status_closed.id
            }
          }
        end

        run_test!
      end

      response 404, 'Fine not found' do
        let(:Authorization) { sign_in }
        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:token) { SecureRandom.uuid }

        let(:fine_param) do
          {
            fine: {
              status_id: status_closed.id
            }
          }
        end

        run_test!
      end

      response 403, 'Status change not allowed' do
        let(:Authorization) { sign_in }
        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        let(:token) do
          user_role_admin.role_id = role_owner.id
          user_role_admin.save!
          fine.token
        end

        let(:fine_param) do
          {
            fine: {
              status_id: status_paid.id
            }
          }
        end

        run_test!
      end
    end
  end
end
