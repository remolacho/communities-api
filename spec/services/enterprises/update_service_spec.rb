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
        email: "#{FFaker::Name.first_name}.#{Random.rand(20..30)}#{Random.rand(20..30)}#{Random.rand(20..30)}@community.com",
        name: 'Test community 1',
        social_reason: 'Test community 1',
        reference_regex: 'ddddd',
        identifier: "#{FFaker::IdentificationESCL.rut}-#{Random.rand(20..129)}"
      }

      service = described_class.new(user: user, enterprise: enterprise, data: params)
      expect { service.call }.to raise_error(ArgumentError)
    end

    it 'Error attribute not allowed' do
      params = {
        address: '',
        email: "#{FFaker::Name.first_name}.#{Random.rand(20..30)}#{Random.rand(20..30)}#{Random.rand(20..30)}@community.com",
        name: 'Test community 1',
        social_reason: 'Test community 1',
        test: 'ddddd',
        identifier: "#{FFaker::IdentificationESCL.rut}-#{Random.rand(20..129)}"
      }

      service = described_class.new(user: user, enterprise: enterprise, data: params)
      expect { service.call }.to raise_error(ActiveModel::UnknownAttributeError)
    end

    it 'Error attribute email required' do
      params = {
        address: '',
        email: '',
        name: 'Test community 1',
        social_reason: 'Test community 1',
        identifier: "#{FFaker::IdentificationESCL.rut}-#{Random.rand(20..129)}"
      }

      service = described_class.new(user: user, enterprise: enterprise, data: params)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'Success!!!' do
      params = {
        address: 'Altos de Berlin',
        email: "#{FFaker::Name.first_name}.#{Random.rand(20..30)}#{Random.rand(20..30)}#{Random.rand(20..30)}@community.com",
        name: 'Test community 1',
        social_reason: 'Test community 1',
        identifier: "#{FFaker::IdentificationESCL.rut}-#{Random.rand(20..129)}"
      }

      service = described_class.new(user: user, enterprise: enterprise, data: params)
      expect(service.call).to be(true)
    end
  end
end
