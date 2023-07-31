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
      file = { '0' => Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/import-user-roles-header-without-roles.csv',
                                                   ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }

      service = described_class.new(enterprise: enterprise, user: user, file: file)
      expect { service.perform }.to raise_error(ArgumentError)
    end

    xit 'return error the header has not roles' do
      file = { '0' => Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/import-user-roles-header-without-roles.xlsx',
                                              ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }

      service = described_class.new(enterprise: enterprise, user: user, file: file)
      expect { service.perform }.to raise_error(ArgumentError)
    end
  end
end
