# frozen_string_literal: true

shared_context 'login_stuff' do
  let(:user) { @user ||= FactoryBot.create(:user) }
  let(:enterprise) { @enterprise ||= FactoryBot.create(:enterprise) }
  let(:user_enterprise) { @user_enterprise ||= FactoryBot.create(:user_enterprise, user_id: user.id, enterprise_id: enterprise.id, active: true) }
end
