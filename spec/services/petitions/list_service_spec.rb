# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::Petitions::ListService do
  include_context 'list_petitions_stuff'

  context 'When 1 user want see to list of petitions' do
    xit 'it return error by role' do
      user.user_roles.find_by(role_id: role_manager.id).delete

      service = described_class.new(user: user, enterprise: enterprise, attr: "", search_term: "")
      expect{service.call(1)}.to raise_exception(PolicyException)
    end
  end
end
