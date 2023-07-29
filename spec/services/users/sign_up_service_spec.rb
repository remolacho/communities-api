# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::Users::SignUpService do
  include_context 'sign_up_stuff'

  context 'When 1 user want begin in app, this should register' do
    it 'it return error address blank' do
      data = allowed_params
      data[:address] = ""

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'it return error address max 30' do
      data = allowed_params
      data[:address] = "1"*31

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'it return error phone blank' do
      data = allowed_params
      data[:phone] = ""

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'it return error phone max 15' do
      data = allowed_params
      data[:phone] = "1"*16

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'it return error phone only numbers' do
      data = allowed_params
      data[:phone] = "1testerr66"

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'it return error email blank' do
      data = allowed_params
      data[:email] = ""

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'it return error email bad format' do
      data = allowed_params
      data[:email] = "test@"

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'it return error email max 50' do
      data = allowed_params
      data[:email] *= 10

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'it return error password empty' do
      data = allowed_params
      data[:password] = ""

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'it return error password min 6' do
      data = allowed_params
      data[:password] = "test"

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'it return error password not match' do
      data = allowed_params
      data[:password] = "test45"

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'it return error identifier blank' do
      data = allowed_params
      data[:identifier] = nil

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'it return error user already exists email duplicate' do
      user_enterprise

      data = allowed_params
      data[:email] = user.email

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotUnique)
    end

    it 'it return error user already exists identifier duplicate' do
      user_enterprise

      data = allowed_params
      data[:identifier] = user.identifier

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotUnique)
    end

    it 'it return success' do
      service = described_class.new(enterprise: enterprise, data: allowed_params)
      expect(service.call.enterprise.subdomain).to eq(enterprise.subdomain)
    end
  end
end

