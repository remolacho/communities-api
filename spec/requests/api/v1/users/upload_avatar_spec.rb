# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe Api::V1::Users::UploadAvatarController, type: :request do
  include_context 'sign_in_stuff'

  let(:lang) { 'es' }
  let(:enterprise_subdomain) { 'public' }

  path '/{enterprise_subdomain}/v1/users/upload_avatar' do
    post 'Allow to users load your image max 1 mb' do
      tags 'Community API V1 Users'
      description 'Allow to users load image for your profile Max 1 mb'
      produces 'application/json'
      consumes 'multipart/form-data'
      parameter name: 'Authorization', in: :header, required: true
      parameter name: :enterprise_subdomain, in: :path, type: :string,
                description: 'this subdomain of enterprise create in creations tenant'
      parameter name: :lang, in: :query, type: :string, description: 'is optional by default is "es"'
      parameter name: :avatar_file, in: :form, type: :file, description: 'the file image user'

      response 200, 'success!!' do
        let(:Authorization) do
          sign_in
        end

        let(:avatar_file) do
          {
            avatar_file: Rack::Test::UploadedFile.new('./spec/files/users/avatars/avatar.jpeg',
                                                      'image/jpeg')
          }
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 message: { type: :string }
               }

        xit ''
      end

      response 422, 'file empty!!' do
        let(:Authorization) do
          sign_in
        end

        let(:avatar_file) do
          {
            avatar_file: ''
          }
        end

        schema type: :object,
               properties: {
                 success: { type: :boolean, default: true },
                 message: { type: :string }
               }

        run_test!
      end

      response 403, 'user not logged!!!' do
        let(:Authorization) { '' }

        let(:avatar_file) do
          {
            avatar_file: Rack::Test::UploadedFile.new('./spec/files/users/avatars/avatar.jpeg',
                                                      'image/jpeg')
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
