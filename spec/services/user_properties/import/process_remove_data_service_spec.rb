# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserProperties::Import::ProcessRemoveDataService do
  include_context 'user_properties_remove_stuff'

  let(:service) { described_class.new(user: user) }

  describe '#call' do
    context 'when deactivating multiple user properties' do
      let(:data_set) do
        [
          { 'identificador' => '12345678', 'localizacion' => 'T1-P1-A101' },
          { 'identificador' => '123456789', 'localizacion' => 'T1-P1-A102' }
        ]
      end

      it 'deactivates both user properties' do
        expect { service.call(data_set) }
          .to change { user_property_one.reload.active }.from(true).to(false)
          .and change { user_property_two.reload.active }.from(true).to(false)
      end
    end

    context 'when deactivating a single user property' do
      let(:data_set) do
        [
          { 'identificador' => '12345678', 'localizacion' => 'T1-P1-A101' }
        ]
      end

      it 'deactivates only the matching user property' do
        expect { service.call(data_set) }
          .to change { user_property_one.reload.active }.from(true).to(false)

        expect(user_property_two.reload.active).to be true
      end
    end

    context 'when data set is empty' do
      let(:data_set) { [] }

      it 'does not modify any user properties' do
        expect { service.call(data_set) }
          .not_to change { UserProperty.where(active: true).count }
      end
    end
  end
end
