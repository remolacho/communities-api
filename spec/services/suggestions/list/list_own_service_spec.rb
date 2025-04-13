# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Suggestions::List::ListOwnService do
  include_context 'list_own_suggestions_stuff'

  context 'When 1 user want see his own list of Suggestions' do
    it 'return empty, the user has not Suggestions' do
      filter = Suggestions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call).to be_empty
    end

    it 'return all' do
      acum = suggestions_anonymous.size
      acum += suggestions.size

      filter = Suggestions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.size).to eq(acum)
    end

    it 'return only read' do
      acum_readed = suggestions_readed.size
      suggestions.size

      params = { read: true }

      filter = Suggestions::Filter::QueryService.new(params: params)
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.size).to eq(acum_readed)
    end
  end
end
