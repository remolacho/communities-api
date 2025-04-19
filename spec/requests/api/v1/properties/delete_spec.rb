# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Properties::DeleteController do
  include_context 'property_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }
  let(:property) do
    FactoryBot.create(:property,
      enterprise: enterprise,
      active: true,
      property_type: apartment_type,
      status: status,
      location: valid_apartment_locations.first
    )
  end
  let(:id) { property.id }

  path '/{enterprise_subdomain}/v1/properties/delete/{id}' do
    delete 'Toggle property active status' do
      tags 'Community API V1 Properties'
      description 'Toggles the active status of a property (active to inactive or vice versa)'
      produces 'application/json'

      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'Subdomain of enterprise'
      parameter name: :id, in: :path, type: :string, description: 'Property ID'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'

      response 200, 'property deleted successfully' do
        let(:Authorization) { sign_in }

        before do
          user_role_admin
          entity_permissions
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean },
                 message: { type: :string }
               },
               required: ['success', 'message']

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['success']).to be true
          expect(data['message']).to eq(I18n.t('services.properties.delete.success'))
          expect(property.reload.active).to be false
        end
      end

      response 403, 'forbidden access' do
        let(:Authorization) { sign_in }

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
    end
  end
end
