# frozen_string_literal: true

shared_context 'enterprise_update_stuff' do
  include RequestHelpers

  let(:role_admin){ FactoryBot.create(:role, :role_admin) }
  let(:role_manager){ FactoryBot.create(:role, :manager) }

  let(:group_edit_enterprise) { FactoryBot.create(:group_role, :edit_enterprise) }

  let(:group_role_relations) {
    [FactoryBot.create(:group_role_relation, role: role_admin, group_role: group_edit_enterprise)]
  }

  let!(:user) { current_user }
  let!(:enterprise) { enterprise_helper }
  let!(:user_enterprise) { user_enterprise_helper }

  let(:other_enterprise) {
    @other_enterprise ||= Enterprise.create(token:SecureRandom.uuid,
                                            name: 'other',
                                            rut: "#{FFaker::IdentificationESCL.rut}-#{20 + Random.rand(110)}",
                                            subdomain: "public-2",
                                            short_name:'tst'.upcase,
                                            email: "#{FFaker::Name.first_name}.#{20 + Random.rand(11)}#{20 + Random.rand(11)}#{20 + Random.rand(11)}@community.com",
                                            reference_regex: "^T[0-4]-P(1[0-6]|[1-9])-A((10[1-8])|(20[1-8])|(30[1-8])|(40[1-8])|(50[1-8])|(60[1-8])|(70[1-8])|(80[1-8])|(90[1-8])|(100[1-8])|(110[1-8])|(120[1-8])|(130[1-8])|(140[1-8])|(150[1-8])|(160[1-8]))$")
  }

  let(:user_role_manager) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_manager.id) }
  let(:user_role_admin) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_admin.id) }
end
