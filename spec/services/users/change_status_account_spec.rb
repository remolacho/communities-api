# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::ChangeStatusAccount do
  include_context 'change_status_stuff'

  context 'When 1 user want change status account to other user' do
    it 'return sucess when from active to inactive' do
      user_enterprise_to_change

      service = described_class.new(user: user, user_to_change: user_to_change)
      service.call

      expect(!user_to_change.active?).to eq(true)
    end

    it 'return sucess when from inactive to active' do
      user_enterprise_to_change

      user_to_change.user_enterprise.update(active: false)

      service = described_class.new(user: user, user_to_change: user_to_change)
      service.call

      expect(user_to_change.active?).to eq(true)
    end
  end
end
