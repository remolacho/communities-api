# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StatusesPetitions::List::Factory::Rejected do
  include_context 'rejected_status_petition_stuff'

  context 'when you want get a list of statuses allowed' do
    it 'the user has not access to list status rejected according to in petition' do
      service = described_class.new(user: user_2, petition: petition)
      expect(service.call.empty?).to eq(true)
    end

    it 'the user has access to list status rejected according to in petition' do
      user_role

      service = described_class.new(user: user, petition: petition)
      result = service.call

      expect(result.detect { |r| r[:code] == Status::PETITION_PENDING }.present?).to eq(true)
    end
  end
end
