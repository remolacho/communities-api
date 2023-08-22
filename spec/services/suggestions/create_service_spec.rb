# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Suggestions::CreateService do
  include_context 'create_suggestion_stuff'

  context 'when you want create a suggestion' do
    it 'error message data empty' do
      service = described_class.new(user: user, data: {})
      expect { service.call }.to raise_error(ArgumentError)
    end

    it 'error message greater than 500 charters' do
      data = {
        message: "1" * 501,
      }

      service = described_class.new(user: user, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'success anonymous!!!' do
      data = {
        message: "message test 1",
        anonymous: true
      }

      service = described_class.new(user: user, data: data)
      expect(service.call.anonymous).to eq true
    end

    it 'success not anonymous!!!' do
      data = {
        message: "message test 1",
      }

      service = described_class.new(user: user, data: data)
      expect(service.call.anonymous).to eq false
    end
  end
end
