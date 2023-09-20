# frozen_string_literal: true

class Menus::Users::Items::AssignRolesItem < ::UserRoles::Import::Create::Policy
  def initialize(user:)
    super(current_user: user)
  end

  def perform
    {
      assignRoles: {
        code: 'assignRoles',
        show: can_show?
      }
    }
  end

  private

  def can_show?
    @can_show ||= has_role?
  end
end
