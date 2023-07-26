# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StatusesPetitions::List::Factory::Confirm do
  include_context 'confirm_status_petition_stuff'

  context 'when you want get a list of statuses allowed' do
    it 'the user has not access to list status confirm according to in petition' do
      current_petition = petition
      current_petition.status_id = status_confirm.id
      current_petition.save!

      service = described_class.new(user: user, petition: current_petition.reload)
      expect(service.call.empty?).to eq(true)
    end

    it 'the user owner has access to list status confirm according to in petition' do
      current_petition = petition
      current_petition.status_id = status_confirm.id
      current_petition.save!

      service = described_class.new(user: user_2, petition: current_petition.reload)
      result = service.call

      expect(result.detect{|r| r[:code] == Status::PETITION_RESOLVE}.present?).to eq(true)
      expect(result.detect{|r| r[:code] == Status::PETITION_REJECTED_SOLUTION}.present?).to eq(true)
    end

    it 'the user with role has access to list status confirm according to in petition' do
      user_role

      current_petition = petition
      current_petition.status_id = status_confirm.id
      current_petition.save!

      service = described_class.new(user: user, petition: current_petition.reload)
      result = service.call

      expect(result.detect{|r| r[:code] == Status::PETITION_REVIEWING}.present?).to eq(true)
    end
  end
end
