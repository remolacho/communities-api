# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Petitions::CreateService do
  include_context 'create_petition_stuff'

  context 'when you want create a PQR' do
    it 'error max files attached!!!' do
      data = {
        title: "Test PQR",
        message: "message test 1",
        category_petition_id: category.id,
        group_role_id: group_role.id,
        files: {
          "0"=> Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/6-finish.xlsx',
                                             ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
         "1"=>  Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/6-finish.xlsx',
                                             ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
         "3"=>  Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/6-finish.xlsx',
                                             ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
        }
      }

      service = described_class.new(user: user, data: data)
      expect{service.call}.to raise_error(ArgumentError)
    end

    it 'error type files attached!!!' do
      data = {
        title: "Test PQR",
        message: "message test 1",
        category_petition_id: category.id,
        group_role_id: group_role.id,
        files: {
          "0"=> Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/6-finish.xlsx',
                                             ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
          "1"=>  Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/1-extension-error.csv',
                                              ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
        }
      }

      service = described_class.new(user: user, data: data)
      expect{service.call}.to raise_error(ArgumentError)
    end

    it 'error size files attached!!!' do
      data = {
        title: "Test PQR",
        message: "message test 1",
        category_petition_id: category.id,
        group_role_id: group_role.id,
        files: {
          "0"=> Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/6-finish.xlsx',
                                             ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
          "1"=>  Rack::Test::UploadedFile.new('./spec/files/users/avatars/muy-grande.png',
                                              ' image/png')
        }
      }

      service = described_class.new(user: user, data: data)
      expect{service.call}.to raise_error(ArgumentError)
    end

    it 'success files attached!!!' do
      data = {
        title: "Test PQR",
        message: "message test 1",
        category_petition_id: category.id,
        group_role_id: group_role.id,
        files: {
          "0"=> Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/6-finish.xlsx',
                                             ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
          "1"=>  Rack::Test::UploadedFile.new('./spec/files/users/avatars/avatar2mb.jpg',
                                              ' image/jpeg')
        }
      }

      service = described_class.new(user: user, data: data)
      petition = service.call
      expect(petition.present?).to eq(true)
      expect(petition.files.attached?).to eq(true)
      expect(petition.files.size).to eq(2)
    end
  end
end
