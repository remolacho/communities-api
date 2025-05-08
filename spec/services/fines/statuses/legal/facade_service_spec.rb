# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Fines::Statuses::Legal::FacadeService do
  include_context 'legal_status_fines_stuff'

  describe '#build' do
    context 'when fine is in assigned state' do
      before do
        fine.update(status: status_assigned)
      end

      it 'returns all possible transitions for admin' do
        user_role_admin
        service = described_class.new(user: user_admin, fine: fine)
        result = service.build

        expect(result.detect { |r| r[:code] == Statuses::FineLegal::FINE_LEGAL_CLOSED }).to be_present
        expect(result.detect { |r| r[:code] == Statuses::FineLegal::FINE_LEGAL_REJECTED }).to be_present
        expect(result.detect { |r| r[:code] == Statuses::FineLegal::FINE_LEGAL_PENDING }).to be_present
        expect(result.detect { |r| r[:code] == Statuses::FineLegal::FINE_LEGAL_PAID }).to be_present
        expect(result.detect { |r| r[:code] == Statuses::FineLegal::FINE_LEGAL_CLAIM }).to be_present
        expect(result.length).to eq(5)
      end

      it 'returns only assigned status for creator' do
        user_role_creator
        service = described_class.new(user: user_creator, fine: fine)
        result = service.build

        expect(result.detect { |r| r[:code] == Statuses::FineLegal::FINE_LEGAL_ASSIGNED }).to be_present
        expect(result.length).to eq(1)
      end
    end

    context 'when fine is in claim state' do
      before do
        fine.update(status: status_claim)
      end

      it 'returns all possible transitions for admin' do
        user_role_admin
        service = described_class.new(user: user_admin, fine: fine)
        result = service.build

        expect(result.detect { |r| r[:code] == Statuses::FineLegal::FINE_LEGAL_PENDING }).to be_present
        expect(result.detect { |r| r[:code] == Statuses::FineLegal::FINE_LEGAL_CLOSED }).to be_present
        expect(result.detect { |r| r[:code] == Statuses::FineLegal::FINE_LEGAL_PAID }).to be_present
        expect(result.length).to eq(3)
      end

      it 'returns only claim status for creator' do
        user_role_creator
        service = described_class.new(user: user_creator, fine: fine)
        result = service.build

        expect(result.detect { |r| r[:code] == Statuses::FineLegal::FINE_LEGAL_CLAIM }).to be_present
        expect(result.length).to eq(1)
      end
    end
  end
end
