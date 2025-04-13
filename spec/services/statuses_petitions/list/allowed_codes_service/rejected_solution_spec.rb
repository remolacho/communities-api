# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StatusesPetitions::List::AllowedCodesService do
  include_context 'rejected_solution_status_petition_stuff'

  context 'when the user owner petition want change the status to rejected solution to other' do
    it 'error change rejected solution to pending' do
      service = described_class.new(user: user_2, petition: petition)
      expect(service).not_to exist(status_pending.code)
    end

    it 'error change rejected solution to confirm' do
      service = described_class.new(user: user_2, petition: petition)
      expect(service).to exist(status_confirm.code)
    end

    it 'error change rejected solution to rejected' do
      service = described_class.new(user: user_2, petition: petition)
      expect(service).not_to exist(status_rejected.code)
    end

    it 'error change rejected solution to resolved' do
      service = described_class.new(user: user_2, petition: petition)
      expect(service).not_to exist(status_resolved.code)
    end

    it 'error change rejected solution to reviewing' do
      service = described_class.new(user: user_2, petition: petition)
      expect(service).not_to exist(status_reviewing.code)
    end
  end

  context 'when the user without role im petition want change the status to rejected solution to other' do
    it 'error change rejected solution to pending' do
      service = described_class.new(user: user, petition: petition)
      expect(service).not_to exist(status_pending.code)
    end

    it 'error change rejected solution to confirm' do
      service = described_class.new(user: user, petition: petition)
      expect(service).not_to exist(status_confirm.code)
    end

    it 'error change rejected solution to rejected' do
      service = described_class.new(user: user, petition: petition)
      expect(service).not_to exist(status_rejected.code)
    end

    it 'error change rejected solution to resolved' do
      service = described_class.new(user: user, petition: petition)
      expect(service).not_to exist(status_resolved.code)
    end

    it 'error change rejected solution to reviewing' do
      service = described_class.new(user: user, petition: petition)
      expect(service).not_to exist(status_reviewing.code)
    end
  end

  context 'when the user with role im petition want change the status to rejected solution to other' do
    it 'error change rejected solution to pending' do
      user_role

      service = described_class.new(user: user, petition: petition)
      expect(service).to exist(status_pending.code)
    end

    it 'error change rejected solution to reviewing' do
      user_role

      service = described_class.new(user: user, petition: petition)
      expect(service).to exist(status_reviewing.code)
    end

    it 'error change rejected solution to confirm' do
      user_role

      service = described_class.new(user: user, petition: petition)
      expect(service).not_to exist(status_confirm.code)
    end

    it 'error change rejected solution to rejected' do
      user_role

      service = described_class.new(user: user, petition: petition)
      expect(service).not_to exist(status_rejected.code)
    end

    it 'error change rejected solution to resolved' do
      user_role

      service = described_class.new(user: user, petition: petition)
      expect(service).not_to exist(status_resolved.code)
    end
  end
end
