shared_context 'warning_status_fines_stuff' do
  include RequestHelpers

  # Status factories
  let!(:status_assigned) { @status_assigned ||= FactoryBot.create(:status, :fine_warning_assigned) }
  let!(:status_closed) { @status_closed ||= FactoryBot.create(:status, :fine_warning_closed) }
  let!(:status_finished) { @status_finished ||= FactoryBot.create(:status, :fine_warning_finished) }
  let!(:status_property) { @status_property ||= FactoryBot.create(:status, :property_own) }

  # Roles
  let(:role_admin) { FactoryBot.create(:role, :role_admin) }
  let(:role_owner) { FactoryBot.create(:role, :owner) }
  let(:role_coexistence_member) { FactoryBot.create(:role, :coexistence_member) }

  # Entity permissions
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
        role: role_owner,
        entity_type: Fine.name,
        can_read: false,
        can_write: false,
        can_destroy: false,
        can_change_status: false
      ),
      FactoryBot.create(:entity_permission,
        role: role_coexistence_member,
        entity_type: Fine.name,
        can_read: true,
        can_write: true,
        can_destroy: true,
        can_change_status: false
      )
    ]
  }

  # Users
  let(:user_admin) { current_user }
  let(:user_enterprise_admin) { user_enterprise_helper }
  let(:user_role_admin) { FactoryBot.create(:user_role, user_id: user_admin.id, role_id: role_admin.id) }

  let(:user_owner) { @user_owner ||= FactoryBot.create(:user) }
  let(:user_enterprise_owner) { FactoryBot.create(:user_enterprise, user_id: user_owner.id, enterprise_id: enterprise_helper.id, active: true) }
  let(:user_role_owner) { FactoryBot.create(:user_role, user_id: user_owner.id, role_id: role_owner.id) }

  let(:user_creator) { @user_creator ||= FactoryBot.create(:user) }
  let(:user_enterprise_creator) { FactoryBot.create(:user_enterprise, user_id: user_creator.id, enterprise_id: enterprise_helper.id, active: true) }
  let(:user_role_creator) { FactoryBot.create(:user_role, user_id: user_creator.id, role_id: role_coexistence_member.id) }

  let(:user_other) { @user_other ||= FactoryBot.create(:user) }
  let(:user_enterprise_other) { FactoryBot.create(:user_enterprise, user_id: user_other.id, enterprise_id: enterprise_helper.id, active: true) }
  let(:user_role_other) { FactoryBot.create(:user_role, user_id: user_other.id, role_id: role_owner.id) }

  # Property and Category
  let(:property_type) { FactoryBot.create(:property_type, :apartamento, enterprise: enterprise_helper) }
  let(:property) {
    FactoryBot.create(:property,
      enterprise: enterprise_helper,
      property_type: property_type,
      status: status_property,
      location: "T1-P1-A101"
    )
  }

  # Property owner relation
  let(:property_owner_type) {
    FactoryBot.create(:property_owner_type,
      enterprise: enterprise_helper,
      code: "OWNER",
      name: "Owner"
    )
  }

  let!(:user_property) {
    FactoryBot.create(:user_property,
      user: user_owner,
      property: property,
      property_owner_type: property_owner_type
    )
  }

  let(:category_fine) {
    FactoryBot.create(:category_fine,
      enterprise: enterprise_helper,
      created_by: user_admin,
      code: "WF-#{SecureRandom.hex(4).upcase}",
      name: "Warning Fine Category",
      description: "Test warning fine category"
    )
  }

  # Fine
  let(:fine) {
    entity_permissions

    user_enterprise_creator
    user_enterprise_owner
    user_enterprise_admin
    user_enterprise_other

    user_role_admin
    user_role_owner
    user_role_creator
    user_role_other
    status_assigned
    entity_permissions

    FactoryBot.create(:fine, :warning,
      title: "Warning Fine Test",
      message: "Test warning fine description",
      status: status_assigned,
      user: user_creator,
      property: property,
      category_fine: category_fine
    )
  }
end
