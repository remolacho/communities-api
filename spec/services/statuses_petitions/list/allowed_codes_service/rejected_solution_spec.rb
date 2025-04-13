# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StatusesPetitions::List::AllowedCodesService do
  include_context 'rejected_solution_status_petition_stuff'

  context 'when the user owner petition want change the status to rejected solution to other' do
    it 'error change rejected solution to pending' do
      service = described_class.new(user: user_2, petition: petition)
      expect(service.exists?(status_pending.code)).to eq(false)
    end

    it 'error change rejected solution to confirm' do
      service = described_class.new(user: user_2, petition: petition)
      expect(service.exists?(status_confirm.code)).to eq(true)
    end

    it 'error change rejected solution to rejected' do
      service = described_class.new(user: user_2, petition: petition)
      expect(service.exists?(status_rejected.code)).to eq(false)
    end

    it 'error change rejected solution to resolved' do
      service = described_class.new(user: user_2, petition: petition)
      expect(service.exists?(status_resolved.code)).to eq(false)
    end

    it 'error change rejected solution to reviewing' do
      service = described_class.new(user: user_2, petition: petition)
      expect(service.exists?(status_reviewing.code)).to eq(false)
    end
  end

  context 'when the user without role im petition want change the status to rejected solution to other' do
    it 'error change rejected solution to pending' do
      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_pending.code)).to eq(false)
    end

    it 'error change rejected solution to confirm' do
      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_confirm.code)).to eq(false)
    end

    it 'error change rejected solution to rejected' do
      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_rejected.code)).to eq(false)
    end

    it 'error change rejected solution to resolved' do
      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_resolved.code)).to eq(false)
    end

    it 'error change rejected solution to reviewing' do
      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_reviewing.code)).to eq(false)
    end
  end

  context 'when the user with role im petition want change the status to rejected solution to other' do
    it 'error change rejected solution to pending' do
      user_role

      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_pending.code)).to eq(true)
    end

    it 'error change rejected solution to reviewing' do
      user_role

      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_reviewing.code)).to eq(true)
    end

    it 'error change rejected solution to confirm' do
      user_role

      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_confirm.code)).to eq(false)
    end

    it 'error change rejected solution to rejected' do
      user_role

      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_rejected.code)).to eq(false)
    end

    it 'error change rejected solution to resolved' do
      user_role

      service = described_class.new(user: user, petition: petition)
      expect(service.exists?(status_resolved.code)).to eq(false)
    end
  end
end
