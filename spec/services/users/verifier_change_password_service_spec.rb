# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::Users::VerifierChangePasswordService do
  include_context 'sign_in_stuff'

  context 'When 1 user want verifier token change password' do
    it 'it return error because the token is empty' do
      service = described_class.new(token: '')
      expect { service.call }.to raise_error(ArgumentError)
    end

    it 'it return error because the token not found' do
      service = described_class.new(token: SecureRandom.uuid)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'it return error because the token expired' do
      forgot = ::Users::ForgotPasswordService.new(email: user.email, expired: -1.day.from_now)
      service = described_class.new(token:  forgot.call.reset_password_key)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'it return success' do
      forgot = ::Users::ForgotPasswordService.new(email: user.email)
      service = described_class.new(token:  forgot.call.reset_password_key)
      expect(service.call.present?).to eq(true)
    end
  end
end
