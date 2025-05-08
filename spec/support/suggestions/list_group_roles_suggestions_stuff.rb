shared_context 'list_group_roles_suggestions_stuff' do
  include RequestHelpers

  let(:role_admin){ FactoryBot.create(:role, :role_admin) }
  let(:role_manager){ FactoryBot.create(:role, :manager) }
  let(:role_owner){ FactoryBot.create(:role, :owner) }

  let(:entity_permissions) {
    [
      FactoryBot.create(:entity_permission,
        role: role_admin,
        entity_type: Suggestion.name,
        can_read: true,
        can_write: true,
        can_destroy: true,
        can_change_status: true
      ),
      FactoryBot.create(:entity_permission,
        role: role_manager,
        entity_type: Suggestion.name,
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
  let(:user_role_manager) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_manager.id) }
  let(:user_role_owner) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_owner.id) }
  let(:user_role_admin) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_admin.id) }

  let(:user_suggestion) { FactoryBot.create(:user) }
  let(:user_enterprise_suggestion) { FactoryBot.create(:user_enterprise, user_id: user_suggestion.id, enterprise_id: enterprise_helper.id, active: true) }
  let(:user_suggestion_role_owner) { FactoryBot.create(:user_role, user_id: user_suggestion.id, role_id: role_owner.id) }

  let(:suggestions_anonymous) {
    user_suggestion

    [
      { message: FFaker::Name.first_name * 10, anonymous: true },
      { message: FFaker::Name.first_name * 10, anonymous: true }
    ].map do |data|
      ::Suggestions::CreateService.new(user: user_suggestion, data: data).call
    end
  }

  let(:suggestions) {
    user_enterprise_suggestion

    [
      { message: FFaker::Name.first_name * 10 },
      { message: FFaker::Name.first_name * 10 }
    ].map do |data|
      ::Suggestions::CreateService.new(user: user_suggestion, data: data).call
    end
  }

  let(:suggestions_readed) {
    user_enterprise_suggestion

    [
      { message: FFaker::Name.first_name * 10, read: true },
      { message: FFaker::Name.first_name * 10, read: true }
    ].map do |data|
      ::Suggestions::CreateService.new(user: user_suggestion, data: data).call
    end
  }

  let(:suggestions_anonymous_readed) {
    user_enterprise_suggestion

    [
      { message: FFaker::Name.first_name * 10, read: true, anonymous: true },
      { message: FFaker::Name.first_name * 10, read: true, anonymous: true }
    ].map do |data|
      ::Suggestions::CreateService.new(user: user_suggestion, data: data).call
    end
  }
end
