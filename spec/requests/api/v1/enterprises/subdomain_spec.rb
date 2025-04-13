# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Enterprises::SubdomainController, type: :request do
  include_context 'enterprise_setting_stuff'

  path '/{enterprise_subdomain}/v1/enterprise/subdomain' do
    get 'valid the subdomain of the enterprise' do
      tags 'Community API V1 Enterprises'
      description 'valid the subdomain of the enterprise'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'this subdomain of enterprise create in creations tenant'

      response 200, 'success!!!' do
        let(:enterprise_subdomain) { 'public' }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 message: { type: :string },
                 data: {
                   type: :object,
                   properties: {
                     logo_url: { type: :string, nullable: true }
                   }
                 }
               }

        run_test!
      end

      response 403, 'error user not valid!!!' do
        let(:enterprise_subdomain) { 'public-test' }

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
