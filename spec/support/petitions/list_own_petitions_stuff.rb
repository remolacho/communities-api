shared_context 'list_own_petitions_stuff' do
  include RequestHelpers

  let(:status_pending) { @status_pending ||= FactoryBot.create(:status, :petition_pending) }
  let(:status_resolved) { @status_resolved ||= FactoryBot.create(:status, :petition_resolved) }

  let(:category_petition) { @category_petition ||= FactoryBot.create(:category_petition, :petition , enterprise: enterprise_helper) }
  let(:category_complaint) { @category_complaint ||= FactoryBot.create(:category_petition, :complaint , enterprise: enterprise_helper) }

  let(:role_coexistence_member){ FactoryBot.create(:role, :coexistence_member) }
  let(:role_council_member){ FactoryBot.create(:role, :council_member) }

  let(:group_role) {
    group = FactoryBot.create(:group_role, :council_coexistence)

    FactoryBot.create(:group_role_relation, role: role_coexistence_member, group_role: group)
    FactoryBot.create(:group_role_relation, role: role_council_member, group_role: group)

    group
  }

  let(:enterprise) { enterprise_helper }
  let(:user) { current_user }
  let(:user_enterprise) { user_enterprise_helper }

  let(:petitions) {
    status_pending
    user_enterprise

    c = [
      {
        title: 'Title Text1',
        message: FFaker::Name.first_name * 10,
        category_petition_id: category_petition.id,
        group_role_id: group_role.id
      },
      {
        title: 'Title Text2',
        message: FFaker::Name.first_name * 10,
        category_petition_id: category_petition.id,
        group_role_id: group_role.id
      }
    ].map do |data|
      ::Petitions::CreateService.new(user: user, data: data).call
    end

    c[0].update(status_id: status_resolved.id)

    c.size
  }

  let(:complaints) {
    status_pending
    user_enterprise

    c = [
      {
        title: 'Title Text3',
        message: FFaker::Name.first_name * 10,
        category_petition_id: category_complaint.id,
        group_role_id: group_role.id
      },
      {
        title: 'Title Text4',
        message: FFaker::Name.first_name * 10,
        category_petition_id: category_complaint.id,
        group_role_id: group_role.id
      }
    ].map do |data|
      ::Petitions::CreateService.new(user: user, data: data).call
    end

    c[0].update(status_id: status_resolved.id)

    c.size
  }
end
