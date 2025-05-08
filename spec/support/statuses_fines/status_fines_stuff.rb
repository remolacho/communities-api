# frozen_string_literal: true

shared_context 'status_fines_stuff' do
  include RequestHelpers

  let(:role_admin) { FactoryBot.create(:role, :role_admin) }
  let(:role_coexistence_member) { FactoryBot.create(:role, :coexistence_member) }

  let(:entity_permissions) {
    [
      FactoryBot.create(:entity_permission,
        role: role_admin,
        entity_type: Fine.name,
        can_read: true,
        can_write: true,
        can_destroy: true,
        can_change_status: true
      ),
      FactoryBot.create(:entity_permission,
        role: role_coexistence_member,
        entity_type: Fine.name,
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

  # Legal fine statuses
  let!(:status_legal_assigned) { FactoryBot.create(:status, :fine_legal_assigned) }
  let!(:status_legal_closed) { FactoryBot.create(:status, :fine_legal_closed) }
  let!(:status_legal_pending) { FactoryBot.create(:status, :fine_legal_pending) }
  let!(:status_legal_rejected) { FactoryBot.create(:status, :fine_legal_rejected) }
  let!(:status_legal_paid) { FactoryBot.create(:status, :fine_legal_paid) }

  # Warning fine statuses
  let!(:status_warning_assigned) { FactoryBot.create(:status, :fine_warning_assigned) }
  let!(:status_warning_closed) { FactoryBot.create(:status, :fine_warning_closed) }
  let!(:status_warning_finished) { FactoryBot.create(:status, :fine_warning_finished) }
end
