# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::ListService do
  include_context 'list_users_stuff'

  context 'When 1 user want see to list of users' do
    it 'return empty because not find [name lastname email identifier reference]' do
      ['name', 'lastname', 'email', 'identifier', 'reference'].each do |attr|
        search = Users::Searches::QueryTermService.new(attr: attr, term: 'test')
        service = described_class.new(user: user, enterprise: enterprise, search: search)
        expect(service.call(1).empty?).to eq(true)
      end
    end

    it 'return users by [name lastname email identifier reference]' do
      ['name', 'lastname', 'email', 'identifier', 'reference'].each do |attr|
        search = Users::Searches::QueryTermService.new(attr: attr, term: user[attr.to_sym][0..3])
        service = described_class.new(user: user, enterprise: enterprise, search: search)
        expect(service.call(1).present?).to eq(true)
      end
    end

    it 'return all users' do
      search = Users::Searches::QueryTermService.new(attr: '', term: '')
      service = described_class.new(user: user, enterprise: enterprise, search: search)
      expect(service.call(1).present?).to eq(true)
    end

    it 'return all users only role manager' do
      user.user_roles.find_by(role_id: role_owner.id).delete

      search = Users::Searches::QueryTermService.new(attr: '', term: '')
      service = described_class.new(user: user, enterprise: enterprise, search: search)
      expect(service.call(1).present?).to eq(true)
    end
  end
end
