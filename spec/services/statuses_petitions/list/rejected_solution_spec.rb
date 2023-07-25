# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StatusesPetitions::List::Factory::RejectedSolution do
  include_context 'rejected_solution_status_petition_stuff'

  context 'when you want get a list of statuses allowed' do
    it 'the user has not access to list status rejected solution according to in petition' do
      current_petition = petition
      current_petition.status_id = status_rejected_solution.id
      current_petition.save!

      service = described_class.new(user: user, petition: current_petition.reload)
      expect(service.call.empty?).to eq(true)
    end

    it 'the user owner has access to list status rejected solution according to in petition' do
      current_petition = petition
      current_petition.status_id = status_rejected_solution.id
      current_petition.save!

      service = described_class.new(user: user_2, petition: current_petition.reload)
      result = service.call

      expect(result.detect{|r| r[:code] == Status::PETITION_CONFIRM}.present?).to eq(true)
    end

    it 'the user with role has access to list status rejected solution according to in petition' do
      user_role

      current_petition = petition
      current_petition.status_id = status_rejected_solution.id
      current_petition.save!

      service = described_class.new(user: user, petition: current_petition.reload)
      result = service.call

      expect(result.detect{|r| r[:code] == Status::PETITION_PENDING}.present?).to eq(true)
    end
  end
end
