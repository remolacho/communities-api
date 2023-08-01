# frozen_string_literal: true

shared_context 'categories_petitions_stuff' do
  include RequestHelpers

  let(:user) { current_user }
  let(:enterprise) { enterprise_helper }
  let(:user_enterprise) { user_enterprise_helper }

  let!(:categories) {
    [
      FactoryBot.create(:category_petition, :petition, enterprise: enterprise),
      FactoryBot.create(:category_petition, :complaint, enterprise: enterprise),
      FactoryBot.create(:category_petition, :claim, enterprise: enterprise)
    ]
  }
end
