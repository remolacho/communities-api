# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::Users::ForgotPasswordService do
  include_context 'sign_in_stuff'

  context 'When 1 user want recover password because it forgot' do
    it 'it return error because the email is empty' do
      service = described_class.new(email: '')
      expect { service.call }.to raise_error(ArgumentError)
    end

    it 'it return error because the email not found' do
      service = described_class.new(email: 'testError@error.com')
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'it return error because the user is inactive' do
      user_enterprise.active = false
      user_enterprise.save

      service = described_class.new(email: user.email)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'it return success with reset_password_key' do
      user_enterprise

      service = described_class.new(email: user.email)
      expect(service.call.reset_password_key.nil?).to eq false
    end
  end
end
