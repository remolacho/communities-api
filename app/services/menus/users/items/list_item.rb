# frozen_string_literal: true

class Menus::Users::Items::ListItem < Users::List::Policy
  def initialize(user:)
    super(current_user: user, enterprise: user.enterprise)
  end

  def perform
    {
      list: {
        code: 'list',
        show: can_show?
      }
    }
  end

  private

  def can_show?
    @can_show ||= has_role?
  end
end
