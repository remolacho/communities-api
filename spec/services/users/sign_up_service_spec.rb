# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::SignUpService do
  include_context 'sign_up_stuff'

  context 'When 1 user want begin in app, this should register' do
    it 'return error reference blank' do
      data = allowed_params
      data[:reference] = ''

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'return error phone blank' do
      data = allowed_params
      data[:phone] = ''

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'return error phone max 15' do
      data = allowed_params
      data[:phone] = '1' * 16

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'return error phone only numbers' do
      data = allowed_params
      data[:phone] = '1testerr66'

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'return error email blank' do
      data = allowed_params
      data[:email] = ''

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'return error email bad format' do
      data = allowed_params
      data[:email] = 'test@'

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'return error email max 50' do
      data = allowed_params
      data[:email] *= 10

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'return error password empty' do
      data = allowed_params
      data[:password] = ''

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'return error password min 6' do
      data = allowed_params
      data[:password] = 'test'

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'return error password not match' do
      data = allowed_params
      data[:password] = 'test45'

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'return error identifier blank' do
      data = allowed_params
      data[:identifier] = nil

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'return error user already exists email duplicate' do
      user_enterprise

      data = allowed_params
      data[:email] = user.email

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotUnique)
    end

    it 'return error user already exists identifier duplicate' do
      user_enterprise

      data = allowed_params
      data[:identifier] = user.identifier

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotUnique)
    end

    it 'return error limit reference' do
      described_class.new(enterprise: enterprise, data: allowed_params).call
      described_class.new(enterprise: enterprise, data: allowed_params_2).call

      service = described_class.new(enterprise: enterprise, data: allowed_params_3)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'return success' do
      service = described_class.new(enterprise: enterprise, data: allowed_params)
      new_user = service.call

      expect(new_user.enterprise.subdomain).to eq(enterprise.subdomain)
      expect(new_user.roles.find_by(code: 'owner_admin').present?).to eq(true)
    end
  end

  context 'When 1 user want begin in app, but reference has error in format' do
    it 'return error reference format T1-A1-P101' do
      data = allowed_params
      data[:reference] = 'T1-A1-P101'

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'return error reference format T, A, P' do
      data = allowed_params
      data[:reference] = 'T, A, P'

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'return error reference format T4P11A-1102' do
      data = allowed_params
      data[:reference] = 'T4P11A-1102'

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'return error reference format t1-p1-A101' do
      data = allowed_params
      data[:reference] = 't1-p1-A101'

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'return error reference format T1-P1-a101' do
      data = allowed_params
      data[:reference] = 'T1-P1-a101'

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'return error reference format T01-P01-A101' do
      data = allowed_params
      data[:reference] = 'T01-P01-A101'

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'return error reference format T1, P1, A99999' do
      data = allowed_params
      data[:reference] = 'T1-P1-A99999'

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'return error reference format T1-P1-AAA' do
      data = allowed_params
      data[:reference] = 'T1-P1-AAA'

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'return error reference format T5-P1-A108' do
      data = allowed_params
      data[:reference] = 'T5-P1-A108'

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'return error reference format T1-P17-A108' do
      data = allowed_params
      data[:reference] = 'T1-P17-A108'

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'return error reference format T1, P16, A1609' do
      data = allowed_params
      data[:reference] = 'T1-P16-A1609'

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'return error reference format T1, P16, A1701' do
      data = allowed_params
      data[:reference] = 'T1-P16-A1701'

      service = described_class.new(enterprise: enterprise, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
