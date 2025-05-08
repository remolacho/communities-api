# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Fines::Statuses::Warning::Finished do
  include_context 'warning_status_fines_stuff'

  context 'when getting list of allowed statuses for finished warning' do
    before do
      fine.update(status: status_finished)
    end

    it 'admin with can_change_status permission can see finished status' do
      user_role_admin
      service = described_class.new(user: user_admin, fine: fine)
      result = service.call

      expect(result.detect { |r| r[:code] == Statuses::FineWarning::FINE_WARNING_FINISHED }).to be_present
      expect(result.length).to eq(1)
    end

    it 'creator can see finished status' do
      user_role_creator
      service = described_class.new(user: user_creator, fine: fine)
      result = service.call

      expect(result.detect { |r| r[:code] == Statuses::FineWarning::FINE_WARNING_FINISHED }).to be_present
      expect(result.length).to eq(1)
    end

    it 'owner can see finished status' do
      user_role_owner
      service = described_class.new(user: user_owner, fine: fine)
      result = service.call

      expect(result.detect { |r| r[:code] == Statuses::FineWarning::FINE_WARNING_FINISHED }).to be_present
      expect(result.length).to eq(1)
    end

    it 'user without any relation cannot access status list' do
      other_user = FactoryBot.create(:user)
      FactoryBot.create(:user_enterprise, user: other_user, enterprise: enterprise_helper, active: true)

      service = described_class.new(user: other_user, fine: fine)
      expect(service.call).to be_empty
    end
  end
end
