# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Petitions::Files::ListService do
  include_context 'create_petition_stuff'

  context 'when you want get the files of the petition' do
    it 'success files attached empty!!!' do
      data = {
        title: "Test PQR",
        message: "message test 1",
        category_petition_id: category.id,
        group_role_id: group_role.id
      }

      petition_service = Petitions::CreateService.new(user: user, data: data)
      petition = petition_service.call

      service = described_class.new(enterprise: enterprise, user: user, petition: petition)
      expect(service.call.empty?).to eq(true)
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

      petition_service = Petitions::CreateService.new(user: user, data: data)
      petition = petition_service.call

      service = described_class.new(enterprise: enterprise, user: user, petition: petition)
      expect(service.call.empty?).to eq(false)
    end
  end
end
