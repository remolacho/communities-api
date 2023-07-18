# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::Users::SignInService do
  include_context 'login_stuff'

  context 'When 1 user want begin in app, this return a JWT or error' do
    it 'it return error by login failed by email' do
      service = described_class.new(email: 'testError@error.com', password: '12345678')
      expect { service.call }.to raise_error(PolicyException)
    end

    it 'it return error by login failed by password' do
      service = described_class.new(email: user.email, password: 'testError')
      expect { service.call }.to raise_error(PolicyException)
    end

    it 'it return error by user inactive' do
      user_enterprise.active = false
      user_enterprise.save

      service = described_class.new(email: user.email, password: user.password)
      expect { service.call }.to raise_error(PolicyException)
    end

    it 'it return success and jwt token' do
      user_enterprise

      service = described_class.new(email: user.email, password: user.password)
      result = service.call

      expect(result.user.present?).to eq true
      expect(result.jwt.present?).to eq true
    end
  end
end
