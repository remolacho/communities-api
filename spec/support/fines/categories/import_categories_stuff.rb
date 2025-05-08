# frozen_string_literal: true

RSpec.shared_context 'import_categories_stuff' do
  include RequestHelpers

  let(:role_admin) { FactoryBot.create(:role, :role_admin) }
  let(:role_coexistence_member) { FactoryBot.create(:role, :coexistence_member) }

  let(:entity_permissions) {
    [
      FactoryBot.create(:entity_permission,
        role: role_admin,
        entity_type: CategoryFine.name,
        can_read: true,
        can_write: true,
        can_destroy: true,
        can_change_status: true
      ),
      FactoryBot.create(:entity_permission,
        role: role_coexistence_member,
        entity_type: CategoryFine.name,
        can_read: false,
        can_write: false,
        can_destroy: false,
        can_change_status: false
      )
    ]
  }

  let(:enterprise) { enterprise_helper }
  let(:user) { current_user }
  let(:user_enterprise) { user_enterprise_helper }

  let(:user_role_admin) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_admin.id) }
  let(:user_role_coexistence_member) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_coexistence_member.id) }

  let(:success_file) do
    Rack::Test::UploadedFile.new(
      './spec/files/category_fines/success.xlsx',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
  end

  let(:duplicated_code_file) do
    Rack::Test::UploadedFile.new(
      './spec/files/category_fines/duplicated_code.xlsx',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
  end

  let(:code_empty_file) do
    Rack::Test::UploadedFile.new(
      './spec/files/category_fines/code_empty.xlsx',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
  end

  let(:all_childs_file) do
    Rack::Test::UploadedFile.new(
      './spec/files/category_fines/all_childs.xlsx',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
  end

  let(:error_header_file) do
    Rack::Test::UploadedFile.new(
      './spec/files/category_fines/error_header.xlsx',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
  end

  let(:only_headers_file) do
    Rack::Test::UploadedFile.new(
      './spec/files/category_fines/only_headers.xlsx',
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )
  end
end
