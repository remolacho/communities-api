# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Properties::Imports::CreateService do
  include_context 'create_property_stuff'

  context 'when you want create one or many properties and attributes' do
    it 'error name empty in property' do
      service = described_class.new(user: user, data: data_error_name)
      expect { service.perform }.to raise_error(ArgumentError)
    end

    it 'error name empty in attribute' do
      service = described_class.new(user: user, data: data_error_name_attr)
      expect { service.perform }.to raise_error(ArgumentError)
    end

    it 'success was added properties' do
      service = described_class.new(user: user, data: data_success)
      expect(service.perform.zero?).to eq(false)
    end
  end
end
