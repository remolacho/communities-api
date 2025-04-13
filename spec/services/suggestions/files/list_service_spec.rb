# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Suggestions::Files::ListService do
  include_context 'create_suggestion_stuff'

  context 'when you want get the files of the suggestion' do
    it 'success files attached empty!!!' do
      data = {
        message: 'message test 1'
      }

      suggestion_service = Suggestions::CreateService.new(user: user, data: data)
      suggestion = suggestion_service.call

      service = described_class.new(enterprise: enterprise, user: user, suggestion: suggestion)
      expect(service.call).to be_empty
    end

    it 'success files attached!!!' do
      data = {
        message: 'message test 1',
        files: {
          '0' => Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/create/6-finish.xlsx',
                                              ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
          '1' => Rack::Test::UploadedFile.new('./spec/files/users/avatars/avatar2mb.jpg',
                                              ' image/jpeg')
        }
      }

      suggestion_service = Suggestions::CreateService.new(user: user, data: data)
      suggestion = suggestion_service.call

      service = described_class.new(enterprise: enterprise, user: user, suggestion: suggestion)
      expect(service.call).not_to be_empty
    end
  end
end
