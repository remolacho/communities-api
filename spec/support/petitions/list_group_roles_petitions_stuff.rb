shared_context 'list_group_roles_petitions_stuff' do
  include RequestHelpers

  let(:status_pending) { FactoryBot.create(:status, :petition_pending) }
  let(:status_resolved) { FactoryBot.create(:status, :petition_resolved) }
  let(:status_rejected) { FactoryBot.create(:status, :petition_rejected) }

  let(:category_petition) {  FactoryBot.create(:category_petition, :petition , enterprise: enterprise_helper) }
  let(:category_complaint) { FactoryBot.create(:category_petition, :complaint , enterprise: enterprise_helper) }
  let(:category_claim) { FactoryBot.create(:category_petition, :claim , enterprise: enterprise_helper) }

  let(:role_coexistence_member){ FactoryBot.create(:role, :coexistence_member) }
  let(:role_council_member){ FactoryBot.create(:role, :council_member) }
  let(:role_owner_admin){ FactoryBot.create(:role, :owner_admin) }
  let(:role_admin){ FactoryBot.create(:role, :role_admin) }

  let(:group_role_council_coexistence) {
    group = FactoryBot.create(:group_role, :council_coexistence)

    FactoryBot.create(:group_role_relation, role: role_coexistence_member, group_role: group)
    FactoryBot.create(:group_role_relation, role: role_council_member, group_role: group)

    group
  }

  let(:group_role_admin) {
    group = FactoryBot.create(:group_role, :admin)

    FactoryBot.create(:group_role_relation, role: role_admin, group_role: group)

    group
  }

  let(:enterprise) { enterprise_helper }
  let(:user) { current_user }
  let(:user_enterprise) { user_enterprise_helper }
  let(:user_role_coexistence_member) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_coexistence_member.id) }
  let(:user_role_council_member) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_council_member.id) }
  let(:user_role_owner_admin) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_owner_admin.id) }
  let(:user_role_admin) { FactoryBot.create(:user_role, user_id: user.id, role_id: role_admin.id) }

  let(:user_2) { FactoryBot.create(:user) }
  let(:user_enterprise_2) {  FactoryBot.create(:user_enterprise, user_id: user_2.id, enterprise_id: enterprise_helper.id, active: true) }
  let(:user_2_role_owner_admin) { FactoryBot.create(:user_role, user_id: user_2.id, role_id: role_owner_admin.id) }

  let(:petitions) {
    status_pending
    user_enterprise_2

    c = [
      {
        title: 'Title Text1',
        message: FFaker::Name.first_name * 10,
        category_petition_id: category_petition.id,
        group_role_id: group_role_council_coexistence.id
      },
      {
        title: 'Title Text2',
        message: FFaker::Name.first_name * 10,
        category_petition_id: category_petition.id,
        group_role_id: group_role_council_coexistence.id
      }
    ].map do |data|
      ::Petitions::CreateService.new(user: user_2, data: data).call
    end

    c[0].update(status_id: status_resolved.id)

    c.size
  }

  let(:complaints) {
    status_pending
    user_enterprise_2

    c = [
      {
        title: 'Title Text3',
        message: FFaker::Name.first_name * 10,
        category_petition_id: category_complaint.id,
        group_role_id: group_role_council_coexistence.id
      },
      {
        title: 'Title Text4',
        message: FFaker::Name.first_name * 10,
        category_petition_id: category_complaint.id,
        group_role_id: group_role_council_coexistence.id
      }
    ].map do |data|
      ::Petitions::CreateService.new(user: user_2, data: data).call
    end

    c[0].update(status_id: status_resolved.id)

    c.size
  }

  let(:claims) {
    status_pending
    user_enterprise_2

    c = [
      {
        title: 'Title Text3',
        message: FFaker::Name.first_name * 10,
        category_petition_id: category_claim.id,
        group_role_id: group_role_admin.id
      },
      {
        title: 'Title Text4',
        message: FFaker::Name.first_name * 10,
        category_petition_id: category_claim.id,
        group_role_id: group_role_admin.id
      }
    ].map do |data|
      ::Petitions::CreateService.new(user: user_2, data: data).call
    end

    c[0].update(status_id: status_rejected.id)

    c.size
  }
end
