# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::Petitions::List::ListOwnService do
  include_context 'list_own_petitions_stuff'

  context 'When 1 user want see his own list of petitions' do
    it 'it return empty, the user has not petitions' do
      service = described_class.new(user: user, filter: filter, page: 1)
      expect(service.call.empty?).to eq(true)
    end
  end
end
