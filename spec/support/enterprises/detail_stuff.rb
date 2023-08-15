# frozen_string_literal: true

shared_context 'detail_stuff' do
  include RequestHelpers

  let!(:user) { current_user }
  let!(:enterprise) { enterprise_helper }
  let!(:user_enterprise) { user_enterprise_helper }
end
