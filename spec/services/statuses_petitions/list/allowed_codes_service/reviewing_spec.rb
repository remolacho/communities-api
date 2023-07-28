# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::StatusesPetitions::List::AllowedCodesService do
  include_context 'reviewing_status_petition_stuff'

  context 'when the user owner petition want change the status to reviewing to other' do
    it 'error change reviewing to pending' do
      service = described_class.new(user: user_2, petition: petition)
      expect(service.exists?(status_pending.code)).to eq(false)
    end

    it 'error change reviewing to confirm' do
      service = described_class.new(user: user_2, petition: petition)
      expect(service.exists?(status_confirm.code)).to eq(false)
    end

    it 'error change reviewing to rejected solution' do
      service = described_class.new(user: user_2, petition: petition)
      expect(service.exists?(status_rejected_solution.code)).to eq(false)
    end

    it 'error change reviewing to rejected' do
      service = described_class.new(user: user_2, petition: petition)
      expect(service.exists?(status_rejected.code)).to eq(false)
    end

    it 'error change reviewing to resolved' do
      service = described_class.new(user: user_2, petition: petition)
      expect(service.exists?(status_resolved.code)).to eq(false)
    end
  end

  context 'when the user without role im petition want change the status to reviewing to other' do
    it 'error change reviewing to pending' do
      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_pending.code)).to eq(false)
    end

    it 'error change reviewing to confirm' do
      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_confirm.code)).to eq(false)
    end

    it 'error change reviewing to rejected solution' do
      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_rejected_solution.code)).to eq(false)
    end

    it 'error change reviewing to rejected' do
      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_rejected.code)).to eq(false)
    end

    it 'error change reviewing to resolved' do
      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_resolved.code)).to eq(false)
    end
  end

  context 'when the user with role im petition want change the status to reviewing to other' do
    it 'error change reviewing to pending' do
      user_role

      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_pending.code)).to eq(true)
    end

    it 'error change reviewing to confirm' do
      user_role

      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_confirm.code)).to eq(true)
    end

    it 'error change reviewing to rejected solution' do
      user_role

      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_rejected_solution.code)).to eq(false)
    end

    it 'error change reviewing to rejected' do
      user_role

      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_rejected.code)).to eq(false)
    end

    it 'error change reviewing to resolved' do
      user_role

      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_resolved.code)).to eq(false)
    end
  end
end
