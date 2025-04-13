# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Petitions::Dashboard::ChartStatusesController do
  include_context 'dashboard_percentage_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/petition/dashboard/chart_statuses' do
    get 'Find all petitions by status and calculate percentage' do
      tags 'Community API V1 Petitions'
      description 'Find all petitions by status and calculate percentage'
      produces 'application/json'
      consumes 'application/json'

      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
      parameter name: 'Authorization', in: :header, required: true

      response 200, 'success lists' do
        let(:Authorization) do
          petitions
          complaints
          claims
          sign_in
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
                       code: { type: :string },
                       name: { type: :string },
                       color: { type: :string },
                       percentage: { type: :number },
                       counter: { type: :integer },
                       total: { type: :integer },
                       symbol: { type: :string }
                     }
                   }
                 }
               }

        run_test!
      end

      response 403, 'error role not allowed!!!' do
        let(:Authorization) { '' }

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
