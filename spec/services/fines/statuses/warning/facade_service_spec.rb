# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Fines::Statuses::Warning::FacadeService do
  include_context 'warning_status_fines_stuff'

  describe '#build' do
    context 'when fine is in assigned state' do
      before do
        fine.update(status: status_assigned)
      end

      it 'returns all possible transitions for admin' do
        user_role_admin
        service = described_class.new(user: user_admin, fine: fine)
        result = service.build

        expect(result.detect { |r| r[:code] == Statuses::FineWarning::FINE_WARNING_CLOSED }).to be_present
        expect(result.detect { |r| r[:code] == Statuses::FineWarning::FINE_WARNING_FINISHED }).to be_present
        expect(result.length).to eq(2)
      end

      it 'returns only assigned status for creator' do
        user_role_creator
        service = described_class.new(user: user_creator, fine: fine)
        result = service.build

        expect(result.detect { |r| r[:code] == Statuses::FineWarning::FINE_WARNING_ASSIGNED }).to be_present
        expect(result.length).to eq(1)
      end
    end

    context 'when fine is in closed state' do
      before do
        fine.update(status: status_closed)
      end

      it 'returns all possible transitions for admin' do
        user_role_admin
        service = described_class.new(user: user_admin, fine: fine)
        result = service.build

        expect(result.detect { |r| r[:code] == Statuses::FineWarning::FINE_WARNING_FINISHED }).to be_present
        expect(result.detect { |r| r[:code] == Statuses::FineWarning::FINE_WARNING_ASSIGNED }).to be_present
        expect(result.length).to eq(2)
      end

      it 'returns only closed status for creator' do
        user_role_creator
        service = described_class.new(user: user_creator, fine: fine)
        result = service.build

        expect(result.detect { |r| r[:code] == Statuses::FineWarning::FINE_WARNING_CLOSED }).to be_present
        expect(result.length).to eq(1)
      end
    end

    context 'when fine is in finished state' do
      before do
        fine.update(status: status_finished)
      end

      it 'returns only finished status for admin as it is terminal' do
        user_role_admin
        service = described_class.new(user: user_admin, fine: fine)
        result = service.build

        expect(result.detect { |r| r[:code] == Statuses::FineWarning::FINE_WARNING_FINISHED }).to be_present
        expect(result.length).to eq(1)
      end

      it 'returns only finished status for creator' do
        user_role_creator
        service = described_class.new(user: user_creator, fine: fine)
        result = service.build

        expect(result.detect { |r| r[:code] == Statuses::FineWarning::FINE_WARNING_FINISHED }).to be_present
        expect(result.length).to eq(1)
      end
    end
  end
end
