shared_context 'status_properties_stuff' do
  include RequestHelpers

  let!(:status_own) { @status_pending ||= FactoryBot.create(:status, :property_own) }
  let!(:status_rented) { @status_pending ||= FactoryBot.create(:status, :property_rented) }
  let!(:status_loan) { @status_pending ||= FactoryBot.create(:status, :property_loan) }
end
