# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Enterprises::UpdateService do
  include_context 'enterprise_update_stuff'

  context 'when you want modify an enterprise' do
    it 'Error data empty' do
      service = described_class.new(user: user, enterprise: enterprise, data: {})
      expect { service.call }.to raise_error(ArgumentError)
    end

    it 'Error field not allowed' do
      params = {
        address: '',
        email: "#{FFaker::Name.first_name}.#{20 + Random.rand(11)}#{20 + Random.rand(11)}#{20 + Random.rand(11)}@community.com",
        name: "Test community 1",
        reference_regex: 'ddddd',
        rut: "#{FFaker::IdentificationESCL.rut}-#{20 + Random.rand(110)}",
      }

      service = described_class.new(user: user, enterprise: enterprise, data: params)
      expect { service.call }.to raise_error(ArgumentError)
    end

    it 'Error attribute not allowed' do
      params = {
        address: '',
        email: "#{FFaker::Name.first_name}.#{20 + Random.rand(11)}#{20 + Random.rand(11)}#{20 + Random.rand(11)}@community.com",
        name: "Test community 1",
        test: 'ddddd',
        rut: "#{FFaker::IdentificationESCL.rut}-#{20 + Random.rand(110)}",
      }

      service = described_class.new(user: user, enterprise: enterprise, data: params)
      expect { service.call }.to raise_error(ActiveModel::UnknownAttributeError)
    end

    it 'Error attribute email required' do
      params = {
        address: '',
        email: "",
        name: "Test community 1",
        rut: "#{FFaker::IdentificationESCL.rut}-#{20 + Random.rand(110)}",
      }

      service = described_class.new(user: user, enterprise: enterprise, data: params)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'Success!!!' do
      params = {
        address: 'Altos de Berlin',
        email: "#{FFaker::Name.first_name}.#{20 + Random.rand(11)}#{20 + Random.rand(11)}#{20 + Random.rand(11)}@community.com",
        name: "Test community 1",
        rut: "#{FFaker::IdentificationESCL.rut}-#{20 + Random.rand(110)}",
      }

      service = described_class.new(user: user, enterprise: enterprise, data: params)
      expect(service.call).to eq(true)
    end
  end
end
