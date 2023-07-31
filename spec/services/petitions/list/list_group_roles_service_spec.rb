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
      group_role_coexistence_committee

      filter = ::Petitions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect { service.call }.to raise_error(PolicyException)
    end
  end
end
