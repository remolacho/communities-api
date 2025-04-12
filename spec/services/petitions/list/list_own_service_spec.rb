# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Petitions::List::ListOwnService do
  include_context 'list_own_petitions_stuff'

  context 'When 1 user want see his own list of petitions' do
    it 'return empty, the user has not petitions' do
      filter = Petitions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.empty?).to eq(true)
    end

    it 'return all without filter' do
      acum = complaints
      acum += petitions

      filter = Petitions::Filter::QueryService.new(params: {})
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.size).to eq(acum)
    end

    it 'return all without filter params empties' do
      acum = complaints
      acum += petitions

      params = {
        status_id: '',
        category_petition_id: ''
      }

      filter = Petitions::Filter::QueryService.new(params: params)
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.size).to eq(acum)
    end

    it 'return all with filter status resolved and category complaint' do
      acum = complaints
      acum += petitions

      params = {
        status_id: status_resolved.id,
        category_petition_id: category_complaint.id
      }

      filter = Petitions::Filter::QueryService.new(params: params)
      service = described_class.new(user: user, filter: filter, page: 1)
      result = service.call

      expect(!result.size.zero? && result.size < acum).to eq(true)
      expect(result.size == 1).to eq(true)
    end

    it 'return all with filter status resolved' do
      acum = complaints
      acum += petitions

      params = {
        status_id: status_resolved.id,
        category_petition_id: ''
      }

      filter = Petitions::Filter::QueryService.new(params: params)
      service = described_class.new(user: user, filter: filter, page: 1)
      result = service.call

      expect(!result.size.zero? && result.size < acum).to eq(true)
      expect(result.size == 2).to eq(true)
    end

    it 'return all with filter category complaint' do
      acum = complaints
      acum += petitions

      params = {
        status_id: '',
        category_petition_id: category_complaint.id
      }

      filter = Petitions::Filter::QueryService.new(params: params)
      service = described_class.new(user: user, filter: filter, page: 1)
      result = service.call

      expect(!result.size.zero? && result.size < acum).to eq(true)
      expect(result.size == 2).to eq(true)
    end

    it 'return empty with filter' do
      complaints
      petitions

      params = { status_id: 999 }

      filter = Petitions::Filter::QueryService.new(params: params)
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.empty?).to eq(true)
    end
  end
end
