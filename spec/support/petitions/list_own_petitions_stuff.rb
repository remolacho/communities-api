shared_context 'list_own_petitions_stuff' do
  include RequestHelpers

  let(:status_pending) { @status_pending ||= FactoryBot.create(:status, :petition_pending) }
  let(:status_resolved) { @status_resolved ||= FactoryBot.create(:status, :petition_resolved) }

  let(:category_petition) { @category ||= FactoryBot.create(:category_petition, :petition , enterprise: enterprise_helper) }
  let(:category_complaint) { @category ||= FactoryBot.create(:category_petition, :complaint , enterprise: enterprise_helper) }

  let(:role1){ FactoryBot.create(:role, :coexistence_member) }
  let(:role2){ FactoryBot.create(:role, :committee_member) }

  let(:group_role) {
    group = FactoryBot.create(:group_role, :coexistence_committee)

    FactoryBot.create(:group_role_relation, role: role1, group_role: group)
    FactoryBot.create(:group_role_relation, role: role2, group_role: group)

    group
  }

  let(:enterprise) { enterprise_helper }
  let(:user) { current_user }
  let(:user_enterprise) { user_enterprise_helper }

  let(:filter){
    {
      status_id: '',
      category_petition_id: ''
    }
  }

  let(:petitions) {
    status_pending
    user_enterprise

    c = [
      {
        title: FFaker::Name.first_name,
        message: FFaker::Name.first_name ,
        category_petition_id: category_petition.id,
        group_role_id: group_role.id
      },
      {
        title: FFaker::Name.first_name,
        message: FFaker::Name.first_name ,
        category_petition_id: category_petition.id,
        group_role_id: group_role.id
      }
    ].map do |data|
      ::Petitions::CreateService.new(user: user, data: data).call
    end

    c[0].update(status_id: status_resolved.id)

  }

  let(:complaints) {
    status_pending
    user_enterprise

    c = [
      {
        title: FFaker::Name.first_name,
        message: FFaker::Name.first_name ,
        category_petition_id: category_complaint.id,
        group_role_id: group_role.id
      },
      {
        title: FFaker::Name.first_name,
        message: FFaker::Name.first_name ,
        category_petition_id: category_complaint.id,
        group_role_id: group_role.id
      }
    ].map do |data|
      ::Petitions::CreateService.new(user: user, data: data).call
    end

    c[0].update(status_id: status_resolved.id)
  }
end
