# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserRoles::Import::CreateService do
  include_context 'user_roles_templates_import_stuff'

  context 'when you want import massively the user roles' do
    it 'return error the file is nil' do
      service = described_class.new(enterprise: enterprise, user: user, file: nil)
      expect { service.perform }.to raise_error(ArgumentError)
    end

    it 'return error the file is not xlsx' do
      file =  Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/1-extension-error.csv',
                                           ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')

      service = described_class.new(enterprise: enterprise, user: user, file: file)
      expect { service.perform }.to raise_error(ArgumentError)
    end

    it 'return error the header has not roles' do
      file = Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/2-error-without-roles-header.xlsx',
                                          ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')

      service = described_class.new(enterprise: enterprise, user: user, file: file)
      expect { service.perform }.to raise_error(ArgumentError)
    end

    it 'return error the header has not identifier' do
      file = Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/3-error-without-identifier-header.xlsx',
                                          ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')

      service = described_class.new(enterprise: enterprise, user: user, file: file)
      expect { service.perform }.to raise_error(ArgumentError)
    end

    it 'return error the header identifier' do
      file = Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/4-error-identifier-header.xlsx',
                                          ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')

      service = described_class.new(enterprise: enterprise, user: user, file: file)
      expect { service.perform }.to raise_error(ArgumentError)
    end

    it 'return error the header role not found' do
      file = Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/5-error-role-not-found.xlsx',
                                          ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')

      service = described_class.new(enterprise: enterprise, user: user, file: file)
      expect { service.perform }.to raise_error(ArgumentError)
    end

    it 'finish with errors' do
      file = Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/6-finish.xlsx',
                                          ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')

      service = described_class.new(enterprise: enterprise, user: user, file: file)
      service.perform

      expect(service.errors).not_to be_empty
    end

    it 'finish success!!!' do
      file = Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/6-finish.xlsx',
                                          ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')

      sign_up

      user_identifier = User.find_by(identifier: '12345678')
      expect(user_identifier.roles.size == 1).to be(true)

      service = described_class.new(enterprise: enterprise, user: user, file: file)
      service.perform

      expect(service.errors).to be_empty
      expect(user_identifier.roles.size == 3).to be(true)
    end

    it 'finish skip duplicate roles' do
      file = Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/6-finish.xlsx',
                                          ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')

      new_user_admin
      user_identifier = User.find_by(identifier: '12345678')
      expect(user_identifier.roles.size == 2).to be(true)

      service = described_class.new(enterprise: enterprise, user: user, file: file)
      service.perform

      expect(service.errors).to be_empty
      expect(user_identifier.roles.size == 3).to be(true)
    end
  end
end
