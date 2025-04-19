# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Enterprises::SettingController do
  include_context 'enterprise_setting_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/enterprise/setting' do
    get 'Find the setting and data of current enterprise' do
      tags 'Community API V1 Enterprises'
      description 'Find the setting and data of current enterprise'
      produces 'application/json'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'

      response 200, 'success!!!' do
        let(:Authorization) { sign_in }

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 data: { type: :object,
                         properties: {
                           token: { type: :string },
                           subdomain: { type: :string },
                           name: { type: :string },
                           logo_url: { type: :string, nullable: true },
                           banner_url: { type: :string, nullable: true },
                           country: {
                             type: :object,
                             properties: {
                               id: { type: :integer },
                               name: { type: :string },
                               code: { type: :string },
                               currency_code: { type: :string },
                               currency_symbol: { type: :string },
                               active: { type: :boolean }
                             }
                           }
                         } }
               }

        run_test!
      end

      response 403, 'error user not valid!!!' do
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
