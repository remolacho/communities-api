# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::Users::ListService do
  include_context 'list_users_stuff'

  context 'When 1 user want see to list of users' do
    it 'it return error by role' do
      user.user_roles.find_by(role_id: role_manager.id).delete

      service = described_class.new(user: user, enterprise: enterprise, attr: "", search_term: "")
      expect{service.call(1)}.to raise_exception(PolicyException)
    end

    it 'it return empty because not find [name lastname email identifier address]' do
      %w[name lastname email identifier address].each do |attr|
        service = described_class.new(user: user, enterprise: enterprise, attr: attr, search_term: 'test')
        expect(service.call(1).empty?).to eq(true)
      end
    end

    it 'it return users by  [name lastname email identifier address]' do
      %w[name lastname email identifier address].each do |attr|
        service = described_class.new(user: user, enterprise: enterprise, attr: attr, search_term: user[attr.to_sym][0..3])
        expect(service.call(1).present?).to eq(true)
      end
    end

    it 'it return all users' do
      service = described_class.new(user: user, enterprise: enterprise, attr: "", search_term: "")
      expect(service.call(1).present?).to eq(true)
    end

    it 'it return all users only role manager' do
      user.user_roles.find_by(role_id: role_owner.id).delete

      service = described_class.new(user: user, enterprise: enterprise, attr: "", search_term: "")
      expect(service.call(1).present?).to eq(true)
    end
  end
end
