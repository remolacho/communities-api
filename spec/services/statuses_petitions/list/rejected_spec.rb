# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StatusesPetitions::List::Factory::Rejected do
  include_context 'rejected_status_petition_stuff'

  context 'when you want get a list of statuses allowed' do
    it 'the user has not access to list status rejected according to in petition' do
      current_petition = petition
      current_petition.status_id = status_rejected.id
      current_petition.save!

      service = described_class.new(user: user_2, petition: current_petition.reload)
      expect(service.call.empty?).to eq(true)
    end

    it 'the user has access to list status rejected according to in petition' do
      user_role

      current_petition = petition
      current_petition.status_id = status_rejected.id
      current_petition.save!

      service = described_class.new(user: user, petition: current_petition.reload)
      result = service.call

      expect(result.detect{|r| r[:code] == Status::PETITION_PENDING}.present?).to eq(true)
    end
  end
end
