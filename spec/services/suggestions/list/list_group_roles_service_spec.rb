# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Suggestions::List::ListGroupRolesService do
  include_context 'list_group_roles_suggestions_stuff'

  context 'When 1 user want see list of Suggestions' do
    it 'return error, the user has not roles' do
      filter = Suggestions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect { service.call }.to raise_error(PolicyException)
    end

    it 'return error, the group role not found' do
      user_role_manager

      filter = Suggestions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect { service.call }.to raise_error(PolicyException)
    end

    it 'return error, the role not found, has not access' do
      user_role_manager
      group_listed_suggestions

      filter = Suggestions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect { service.call }.to raise_error(PolicyException)
    end

    it 'return error, the role not found, has not access owner' do
      user_role_owner
      group_listed_suggestions
      group_role_relations

      filter = Suggestions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect { service.call }.to raise_error(PolicyException)
    end

    it 'return success, but empty for role manager' do
      user_role_manager
      group_listed_suggestions
      group_role_relations

      filter = Suggestions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.empty?).to eq(true)
    end

    it 'return success, all suggestions without filter' do
      user_role_manager
      group_listed_suggestions
      group_role_relations
      acum = suggestions_anonymous.size
      acum += suggestions.size

      filter = Suggestions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.size).to eq(acum)
    end

    it 'return success, all suggestions read' do
      user_role_manager
      group_listed_suggestions
      group_role_relations
      acum = suggestions_readed.size
      suggestions.size

      params = { read: true }

      filter = Suggestions::Filter::QueryService.new(params: params)
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.size).to eq(acum)
    end

    it 'return success, all suggestions anonymous' do
      user_role_manager
      group_listed_suggestions
      group_role_relations
      acum = suggestions_anonymous.size
      suggestions.size

      params = { anonymous: true }

      filter = Suggestions::Filter::QueryService.new(params: params)
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.size).to eq(acum)
    end

    it 'return success, all suggestions read and anonymous' do
      user_role_manager
      group_listed_suggestions
      group_role_relations
      acum = suggestions_anonymous_readed.size
      suggestions.size

      params = { anonymous: true, read: true }

      filter = Suggestions::Filter::QueryService.new(params: params)
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.size).to eq(acum)
    end

    it 'return success, all suggestions that are not anonymous' do
      user_role_manager
      group_listed_suggestions
      group_role_relations

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
      user_role_manager
      group_listed_suggestions
      group_role_relations

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
