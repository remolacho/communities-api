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
      expect(user_sign_up).not_to be_active

      service = described_class.new(token: user_sign_up.active_key)
      expect(service.call).to be(true)

      user_sign_up = user_sign_up.reload
      expect(user_sign_up.active_key).to be_nil
      expect(user_sign_up).to be_active
    end
  end
end
