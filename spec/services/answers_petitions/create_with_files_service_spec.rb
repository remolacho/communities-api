# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersPetitions::CreateService do
  include_context 'create_answer_petition_stuff'

  context 'when you want create 1 answer to PQR' do
    it 'error max limit files' do
      user_enterprise_answer
      user_role_answer

      data = {
        message: 'test message 1',
        files: {
          '0' => Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/6-finish.xlsx',
                                              ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
          '1' => Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/6-finish.xlsx',
                                              ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
          '3' => Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/6-finish.xlsx',
                                              ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
        }
      }

      service = described_class.new(petition: petition, user: user_answer, data: data)
      expect { service.call }.to raise_error(ArgumentError)
    end

    it 'error type files attached' do
      user_enterprise_answer
      user_role_answer

      data = {
        message: 'test message 1',
        files: {
          '0' => Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/6-finish.xlsx',
                                              ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
          '1' => Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/1-extension-error.csv',
                                              ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
        }
      }

      service = described_class.new(petition: petition, user: user_answer, data: data)
      expect { service.call }.to raise_error(ArgumentError)
    end

    it 'error size files attached' do
      user_enterprise_answer
      user_role_answer

      data = {
        message: 'test message 1',
        files: {
          '0' => Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/6-finish.xlsx',
                                              ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
          '1' => Rack::Test::UploadedFile.new('./spec/files/users/avatars/muy-grande.png',
                                              ' image/png')
        }
      }

      service = described_class.new(petition: petition, user: user_answer, data: data)
      expect { service.call }.to raise_error(ArgumentError)
    end

    it 'success the user has role in the petition' do
      user_enterprise_answer
      user_role_answer

      data = {
        message: 'test message 1',
        files: {
          '0' => Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/6-finish.xlsx',
                                              ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
          '1' => Rack::Test::UploadedFile.new('./spec/files/users/avatars/avatar2mb.jpg',
                                              ' image/jpeg')
        }
      }

      service = described_class.new(petition: petition, user: user_answer, data: data)

      answer = service.call
      expect(answer).to be_present
      expect(answer.files).to be_attached
      expect(answer.files.size).to eq(2)
    end
  end
end
