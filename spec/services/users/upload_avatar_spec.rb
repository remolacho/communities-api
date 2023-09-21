# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::Users::UploadAvatar do
  include_context 'sign_in_stuff'

  context 'When 1 user want load your avatar in app' do
    it 'it return error file nil' do
      service = described_class.new(user: user, avatar_file: nil)

      expect{ service.perform }.to raise_error(ArgumentError)
    end

    it 'it return error xlsx' do
      file = Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/6-finish.xlsx',
                                          ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')

      service = described_class.new(user: user, avatar_file: file)

      expect{ service.perform }.to raise_error(ArgumentError)
    end

    it 'it return error avatar size' do
      file = Rack::Test::UploadedFile.new('./spec/files/users/avatars/muy-grande.png',
                                          'image/png')

      service = described_class.new(user: user, avatar_file: file)

      expect{ service.perform }.to raise_error(ArgumentError)
    end

    it 'it return success' do
      file = Rack::Test::UploadedFile.new('./spec/files/users/avatars/avatar.jpeg',
                                   'image/jpeg')

      service = described_class.new(user: user, avatar_file: file)

      expect(service.perform).to eq(true)
    end
  end
end
