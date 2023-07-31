# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserRoles::Templates::ImportService do
  include_context 'user_roles_templates_import_stuff'

  context 'when you want get a template of importation for user roles' do
    it 'return success' do
      service = described_class.new(enterprise: enterprise)
      result = service.build
      expect(result.name_file.present?).to eq(true)
      expect(result.file.to_stream.present?).to eq(true)
    end
  end
end
