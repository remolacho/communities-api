# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Enterprises::UpdateService do
  include_context 'enterprise_update_stuff'

  context 'when you want modify an enterprise' do
    it 'it return error logo extension' do
      logo = Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/6-finish.xlsx',
                                           ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')

      params = {
        address: 'Altos de Berlin',
        email: "#{FFaker::Name.first_name}.#{20 + Random.rand(11)}#{20 + Random.rand(11)}#{20 + Random.rand(11)}@community.com",
        name: "Test community 1",
        rut: "#{FFaker::IdentificationESCL.rut}-#{20 + Random.rand(110)}",
        logo: logo
      }

      service = described_class.new(user: user, enterprise: enterprise, data: params)
      expect{ service.call }.to raise_error(ArgumentError)
    end

    it 'it return error banner extension' do
      banner = Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/6-finish.xlsx',
                                           ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')

      params = {
        address: 'Altos de Berlin',
        email: "#{FFaker::Name.first_name}.#{20 + Random.rand(11)}#{20 + Random.rand(11)}#{20 + Random.rand(11)}@community.com",
        name: "Test community 1",
        rut: "#{FFaker::IdentificationESCL.rut}-#{20 + Random.rand(110)}",
        banner: banner
      }

      service = described_class.new(user: user, enterprise: enterprise, data: params)
      expect{ service.call }.to raise_error(ArgumentError)
    end

    it 'it return error logo size' do
      logo = Rack::Test::UploadedFile.new('./spec/files/users/avatars/avatar2mb.jpg',
                                           'image/jpeg')

      params = {
        address: 'Altos de Berlin',
        email: "#{FFaker::Name.first_name}.#{20 + Random.rand(11)}#{20 + Random.rand(11)}#{20 + Random.rand(11)}@community.com",
        name: "Test community 1",
        rut: "#{FFaker::IdentificationESCL.rut}-#{20 + Random.rand(110)}",
        logo: logo
      }

      service = described_class.new(user: user, enterprise: enterprise, data: params)
      expect{ service.call }.to raise_error(ArgumentError)
    end

    it 'it return error banner size' do
      banner = Rack::Test::UploadedFile.new('./spec/files/users/avatars/avatar2mb.jpg',
                                           'image/jpeg')

      params = {
        address: 'Altos de Berlin',
        email: "#{FFaker::Name.first_name}.#{20 + Random.rand(11)}#{20 + Random.rand(11)}#{20 + Random.rand(11)}@community.com",
        name: "Test community 1",
        rut: "#{FFaker::IdentificationESCL.rut}-#{20 + Random.rand(110)}",
        banner: banner
      }

      service = described_class.new(user: user, enterprise: enterprise, data: params)
      expect{ service.call }.to raise_error(ArgumentError)
    end

    it 'it return success' do
      logo = Rack::Test::UploadedFile.new('./spec/files/users/avatars/avatar.jpeg',
                                             'image/jpeg')

      banner = Rack::Test::UploadedFile.new('./spec/files/users/avatars/avatar.jpeg',
                                   'image/jpeg')

      params = {
        address: 'Altos de Berlin',
        email: "#{FFaker::Name.first_name}.#{20 + Random.rand(11)}#{20 + Random.rand(11)}#{20 + Random.rand(11)}@community.com",
        name: "Test community 1",
        rut: "#{FFaker::IdentificationESCL.rut}-#{20 + Random.rand(110)}",
        logo: logo,
        banner: banner
      }

      service = described_class.new(user: user, enterprise: enterprise, data: params)
      expect(service.call).to eq(true)
    end
  end
end
