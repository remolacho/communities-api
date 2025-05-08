# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Suggestions::List::ListGroupRolesService do
  include_context 'list_group_roles_suggestions_stuff'

  context 'When 1 user want see list of Suggestions' do
    it 'return error, the user has not roles' do
      entity_permissions
      filter = Suggestions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect { service.call }.to raise_error(PolicyException)
    end

    it 'return error, the entity role not found' do
      user_role_manager

      filter = Suggestions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect { service.call }.to raise_error(PolicyException)
    end

    it 'return error, the role not found, has not access' do
      entity_permissions
      user_role_manager

      filter = Suggestions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect { service.call }.to raise_error(PolicyException)
    end

    it 'return error, the role not found, has not access owner' do
      entity_permissions
      user_role_owner

      filter = Suggestions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect { service.call }.to raise_error(PolicyException)
    end

    it 'return success, but empty for role admin' do
      entity_permissions
      user_role_admin

      filter = Suggestions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call).to be_empty
    end

    it 'return success, all suggestions without filter' do
      entity_permissions
      user_role_admin
      acum = suggestions_anonymous.size
      acum += suggestions.size

      filter = Suggestions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.size).to eq(acum)
    end

    it 'return success, all suggestions read' do
      entity_permissions
      user_role_admin
      acum = suggestions_readed.size
      suggestions.size

      params = { read: true }

      filter = Suggestions::Filter::QueryService.new(params: params)
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.size).to eq(acum)
    end

    it 'return success, all suggestions anonymous' do
      entity_permissions
      user_role_admin
      acum = suggestions_anonymous.size
      suggestions.size

      params = { anonymous: true }

      filter = Suggestions::Filter::QueryService.new(params: params)
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.size).to eq(acum)
    end

    it 'return success, all suggestions read and anonymous' do
      entity_permissions
      user_role_admin
      acum = suggestions_anonymous_readed.size
      suggestions.size

      params = { anonymous: true, read: true }

      filter = Suggestions::Filter::QueryService.new(params: params)
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.size).to eq(acum)
    end

    it 'return success, all suggestions that are not anonymous' do
      entity_permissions
      user_role_admin

      acum = suggestions.size
      acum += suggestions_readed.size

      suggestions_anonymous
      suggestions_anonymous_readed

      params = { anonymous: false }

      filter = Suggestions::Filter::QueryService.new(params: params)
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.size).to eq(acum)
    end

    it 'return success, all suggestions that are not read' do
      entity_permissions
      user_role_admin

      acum = suggestions.size
      acum += suggestions_anonymous.size

      suggestions_readed
      suggestions_anonymous_readed

      params = { read: false }

      filter = Suggestions::Filter::QueryService.new(params: params)
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.size).to eq(acum)
    end
  end
end
