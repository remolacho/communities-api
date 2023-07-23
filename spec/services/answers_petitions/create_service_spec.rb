# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersPetitions::CreateService do
  include_context 'create_answer_petition_stuff'

  context 'when you want create 1 answer to PQR' do
    it 'error message data empty' do

      service = described_class.new(petition: petition, user: user, data: {})
      expect { service.call }.to raise_error(ArgumentError)
    end

    it 'error message status resolved' do
      p = petition
      p.status_id = status_resolved.id
      p.save!

      data = {
        message: 'test message 1'
      }

      service = described_class.new(petition: p, user: user, data: data)
      expect { service.call }.to raise_error(PolicyException)
    end

    it 'error message greater than 500 charters' do
      data = {
        message: "1" * 501,
      }

      service = described_class.new(petition: petition, user: user, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'error message not allow role' do
      user_enterprise_answer

      data = {
        message: 'test message 1'
      }

      service = described_class.new(petition: petition, user: user_answer, data: data)
      expect { service.call }.to raise_error(PolicyException)
    end

    it 'success the user is owner petition' do
      data = {
        message: 'test message 1'
      }

      service = described_class.new(petition: petition, user: user, data: data)
      expect(service.call.present?).to eq true
    end

    it 'success the user has role in the petition' do
      user_enterprise_answer
      user_role_answer

      data = {
        message: 'test message 1'
      }

      service = described_class.new(petition: petition, user: user_answer, data: data)
      expect(service.call.present?).to eq true
    end
  end
end
