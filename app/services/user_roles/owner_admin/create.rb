# frozen_string_literal: true

class UserRoles::OwnerAdmin::Create
  attr_accessor :user

  def initialize(user:)
    @user = user
  end

  def call
    user.user_roles.create!(role_id: role.id, created_by: user.id)
    user
  end

  private

  def role
    @role ||= Role.find_by!(code: 'oamin')
  end
end
