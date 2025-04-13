# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StatusesPetitions::List::Factory::Reviewing do
  include_context 'reviewing_status_petition_stuff'

  context 'when you want get a list of statuses allowed' do
    it 'the user has not access to list status reviewing according to in petition' do
      service = described_class.new(user: user_2, petition: petition)
      expect(service.call).to be_empty
    end

    it 'the user has access to list status reviewing according to in petition' do
      user_role

      service = described_class.new(user: user, petition: petition)
      result = service.call

      expect(result.detect { |r| r[:code] == Status::PETITION_PENDING }).to be_present
      expect(result.detect { |r| r[:code] == Status::PETITION_CONFIRM }).to be_present
    end
  end
end
