# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::ActiveAccountService do
  include_context 'sign_up_stuff'

  context 'When 1 user want activate account' do
    it 'return error because the token is empty' do
      service = described_class.new(token: '')
      expect { service.call }.to raise_error(ArgumentError)
    end

    it 'return error because the token not found' do
      service = described_class.new(token: SecureRandom.uuid)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'return success' do
      user_sign_up = Users::SignUpService.new(enterprise: enterprise, data: allowed_params).call
      expect(user_sign_up.active?).to eq(false)

      service = described_class.new(token: user_sign_up.active_key)
      expect(service.call).to eq(true)

      user_sign_up = user_sign_up.reload
      expect(user_sign_up.active_key.nil?).to eq(true)
      expect(user_sign_up.active?).to eq(true)
    end
  end
end
