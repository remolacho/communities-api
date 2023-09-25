# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Properties::Templates::AssignController, type: :request do
  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}v1/properties/templates/assign' do
    get 'Allow to users download a tempelate for assign the properties to enterprise' do
      tags 'Community API V1 properties'
      description "Allow to users download a tempelate for assign the properties to enterprise"
      consumes 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
      parameter name: :enterprise_subdomain, in: :path, type: :string, description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'

      response 200, 'success down laod file!!!' do
        xit ""
      end
    end
  end
end
