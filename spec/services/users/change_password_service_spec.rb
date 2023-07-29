# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::Users::ChangePasswordService do
  include_context 'sign_in_stuff'

  let(:allowed_params){
    {
      password: '12345678',
      password_confirmation: '12345678'
    }
  }

  context 'When 1 user want verifier token change password' do
    it 'it return error because the password not match' do
      forgot = ::Users::ForgotPasswordService.new(email: user.email)

      data = allowed_params
      data[:password_confirmation] = ""

      service = described_class.new(token:  forgot.call.reset_password_key, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'it return error because the password is empty' do
      forgot = ::Users::ForgotPasswordService.new(email: user.email)

      data = allowed_params
      data[:password] = ""

      service = described_class.new(token:  forgot.call.reset_password_key, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'it return error because min size password' do
      forgot = ::Users::ForgotPasswordService.new(email: user.email)

      data = allowed_params
      data[:password] = "12345"
      data[:password_confirmation] = "12345"

      service = described_class.new(token:  forgot.call.reset_password_key, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'it return success' do
      forgot = ::Users::ForgotPasswordService.new(email: user.email)
      service = described_class.new(token:  forgot.call.reset_password_key, data: allowed_params)

      expect(user.reload.reset_password_key.nil?).to eq(false)
      expect(service.call).to eq(true)
      expect(user.reload.reset_password_key.nil?).to eq(true)
    end
  end
end
