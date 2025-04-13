# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::VerifierChangePasswordService do
  include_context 'sign_in_stuff'

  context 'When 1 user want verifier token change password' do
    it 'return error because the token is empty' do
      service = described_class.new(token: '')
      expect { service.call }.to raise_error(ArgumentError)
    end

    it 'return error because the token not found' do
      service = described_class.new(token: SecureRandom.uuid)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'return error because the token expired' do
      forgot = Users::ForgotPasswordService.new(email: user.email, expired: -1.day.from_now)
      service = described_class.new(token: forgot.call.reset_password_key)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'return error because the user inactive' do
      forgot = Users::ForgotPasswordService.new(email: user.email)
      token = forgot.call.reset_password_key

      user.user_enterprise.update(active: false)

      service = described_class.new(token: token)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'returns success' do
      forgot = Users::ForgotPasswordService.new(email: user.email)
      service = described_class.new(token: forgot.call.reset_password_key)
      expect(service.call).to be_present
    end
  end
end
