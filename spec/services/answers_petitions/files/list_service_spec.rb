# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersPetitions::Files::ListService do
  include_context 'create_answer_petition_stuff'

  context 'when you want get the files of the answer' do
    it 'success files attached empty!!!' do
      user_enterprise_answer
      user_role_answer

      data = {
        message: 'test message 1'
      }

      service_answer = AnswersPetitions::CreateService.new(petition: petition, user: user_answer, data: data)
      answer = service_answer.call

      service = described_class.new(enterprise: enterprise, answer: answer, user: user_answer)
      expect(service.call.empty?).to eq(true)
    end

    it 'success files attached!!!' do
      user_enterprise_answer
      user_role_answer

      data = {
        message: 'test message 1',
        files: {
          "0"=> Rack::Test::UploadedFile.new('./spec/files/user_roles/templates/6-finish.xlsx',
                                             ' application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
          "1"=>  Rack::Test::UploadedFile.new('./spec/files/users/avatars/avatar2mb.jpg',
                                              ' image/jpeg')
        }
      }

      service_answer = AnswersPetitions::CreateService.new(petition: petition, user: user_answer, data: data)
      answer = service_answer.call

      service = described_class.new(enterprise: enterprise, answer: answer, user: user_answer)
      expect(service.call.empty?).to eq(false)
    end
  end
end
