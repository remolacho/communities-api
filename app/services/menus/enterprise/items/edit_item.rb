# frozen_string_literal: true

class Menus::Enterprise::Items::EditItem < ::Enterprises::Update::Policy
  def initialize(user:)
    super(current_user: user)
  end

  def perform
    {
      edit: {
        code: 'edit',
        show: can_show?
      }
    }
  end

  private

  def can_show?
    @can_show ||= has_role?
  end
end
