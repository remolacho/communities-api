# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::Petitions::List::FactoryService do
  include_context 'list_petitions_stuff'

  context 'When 1 user want see to list of petitions' do
    it 'it return error by role' do
      service = described_class.new(user: user, filter: filter)
      expect{service.call(1)}.to raise_exception(PolicyException)
    end
  end
end
