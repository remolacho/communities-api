# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::Petitions::List::ListGroupRolesService do
  include_context 'list_group_roles_petitions_stuff'

  context 'When 1 user want see list of petitions' do
    it 'it return error, the user has not roles' do
      filter = ::Petitions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect { service.call }.to raise_error(PolicyException)
    end

    it 'it return error, the user only has role owner admin' do
      user_role_owner_admin
      group_role_council_coexistence

      filter = ::Petitions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect { service.call }.to raise_error(PolicyException)
    end

    it 'it return empty, the user has role admin, but there is not petitions' do
      user_role_owner_admin
      user_role_admin
      group_role_admin

      filter = ::Petitions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.empty?).to eq(true)
    end

    it 'it return only group admin, the user has role admin' do
      user_role_owner_admin
      user_role_admin
      group_role_admin

      acum = claims
      petitions
      complaints

      filter = ::Petitions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.size).to eq(acum)
    end

    it 'it return empty there is not petitions for group role admin, the user has role admin' do
      user_role_owner_admin
      user_role_admin
      group_role_admin

      petitions
      complaints

      filter = ::Petitions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.empty?).to eq(true)
    end

    it 'it return only group admin with filter status rejected, the user has role admin' do
      user_role_owner_admin
      user_role_admin
      group_role_admin

      acum = claims
      acum += petitions
      acum += complaints

      params = {
        status_id: status_rejected.id,
        category_petition_id: ''
      }

      filter = ::Petitions::Filter::QueryService.new(params: params)
      service = described_class.new(user: user, filter: filter, page: 1)

      result = service.call
      expect(result.size > 0 && result.size < acum).to eq(true)
    end

    it 'it return only group admin with filter category claim, the user has role admin' do
      user_role_owner_admin
      user_role_admin
      group_role_admin

      acum = claims
      petitions
      complaints

      params = {
        category_petition_id: category_claim.id
      }

      filter = ::Petitions::Filter::QueryService.new(params: params)
      service = described_class.new(user: user, filter: filter, page: 1)

      result = service.call
      expect(result.size).to eq(acum)
    end

    it 'it return all' do
      user_role_owner_admin
      user_role_admin
      group_role_admin
      user_role_council_member

      acum = claims
      acum += petitions
      acum += complaints

      filter = ::Petitions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)

      result = service.call
      expect(result.size).to eq(acum)
    end
  end
end
