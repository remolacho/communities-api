# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Enterprises::UpdateController do
  include_context 'enterprise_update_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/enterprise/update/{token}' do
    put 'Modify the profile of the current enterprise' do
      tags 'Community API V1 Enterprises'
      description 'Modify the profile of the current enterprise'
      produces 'application/json'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
      parameter name: :token, in: :path, type: :string, description: 'token of the enterprise"'
      parameter name: :params_enterprise, in: :body, schema: {
        type: :object,
        properties: {
          enterprise: {
            type: :object,
            properties: {
              name: { type: :string },
              email: { type: :string },
              address: { type: :string },
              rut: { type: :string },
              logo: { type: :string, description: 'the file of image' },
              banner: { type: :string, description: 'the file of image' }
            }
          }
        }
      }

      response 200, 'success!!!' do
        let(:Authorization) do
          group_role_relations
          user_role_admin
          sign_in
        end

        let(:token) { enterprise.token }

        let(:params_enterprise) do
          {
            enterprise: {
              address: 'Altos de Berlin',
              email: "#{FFaker::Name.first_name}.#{Random.rand(20..30)}#{Random.rand(20..30)}#{Random.rand(20..30)}@community.com",
              name: 'Test community 1',
              rut: "#{FFaker::IdentificationESCL.rut}-#{Random.rand(20..129)}"
            }
          }
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 message: { type: :string }
               }

        run_test!
      end

      response 404, 'error enterprise not valid!!!' do
        let(:Authorization) do
          group_role_relations
          user_role_admin
          sign_in
        end

        let(:token) { other_enterprise.token }

        let(:params_enterprise) do
          {
            enterprise: {
              address: 'Altos de Berlin',
              email: "#{FFaker::Name.first_name}.#{Random.rand(20..30)}#{Random.rand(20..30)}#{Random.rand(20..30)}@community.com",
              name: 'Test community 1',
              rut: "#{FFaker::IdentificationESCL.rut}-#{Random.rand(20..129)}"
            }
          }
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        run_test!
      end

      response 404, 'error enterprise not found!!!' do
        let(:Authorization) do
          group_role_relations
          user_role_admin
          sign_in
        end

        let(:token) { SecureRandom.uuid }

        let(:params_enterprise) do
          {
            enterprise: {
              address: 'Altos de Berlin',
              email: "#{FFaker::Name.first_name}.#{Random.rand(20..30)}#{Random.rand(20..30)}#{Random.rand(20..30)}@community.com",
              name: 'Test community 1',
              rut: "#{FFaker::IdentificationESCL.rut}-#{Random.rand(20..129)}"
            }
          }
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: false },
                 message: { type: :string }
               }

        run_test!
      end

      response 403, 'error user not valid!!!' do
        let(:Authorization) do
          group_role_relations
          user_role_manager
          sign_in
        end

        let(:token) { enterprise.token }

        let(:params_enterprise) do
          {
            enterprise: {
              address: 'Altos de Berlin',
              email: "#{FFaker::Name.first_name}.#{Random.rand(20..30)}#{Random.rand(20..30)}#{Random.rand(20..30)}@community.com",
              name: 'Test community 1',
              rut: "#{FFaker::IdentificationESCL.rut}-#{Random.rand(20..129)}"
            }
          }
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
