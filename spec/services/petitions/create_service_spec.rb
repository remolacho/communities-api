# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Petitions::CreateService do
  include_context 'create_petition_stuff'

  context 'when you want create a PQR' do
    it 'error message data empty' do
      service = described_class.new(user: user, data: {})
      expect { service.call }.to raise_error(ArgumentError)
    end

    it 'error title greater than 500 charters' do
      data = {
        title: 'T' * 50,
        category_petition_id: category.id,
        group_role_id: group_role.id
      }

      service = described_class.new(user: user, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'error message greater than 500 charters' do
      data = {
        title: 'Test PQR',
        message: '1' * 501,
        category_petition_id: category.id,
        group_role_id: group_role.id
      }

      service = described_class.new(user: user, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'error message category not found' do
      data = {
        title: 'Test PQR',
        message: 'message test 1',
        category_petition_id: 9999,
        group_role_id: group_role.id
      }

      service = described_class.new(user: user, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'error message group role not found' do
      data = {
        title: 'Test PQR',
        message: 'message test 1',
        category_petition_id: category.id,
        group_role_id: 9999
      }

      service = described_class.new(user: user, data: data)
      expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'success!!!' do
      data = {
        title: 'Test PQR',
        message: 'message test 1',
        category_petition_id: category.id,
        group_role_id: group_role.id
      }

      service = described_class.new(user: user, data: data)
      expect(service.call.ticket.present?).to eq true
    end
  end
end
