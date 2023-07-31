# frozen_string_literal: true

class UserRoles::Templates::Policy < ::BasePolicy
  def initialize(current_user:)
    super(current_user: current_user)
  end

  def can_read!
    loudly do
      (allowed_roles & user_roles).any?
    end
  end

  private

  def user_roles
    @user_roles ||= current_user.roles.pluck(:code)
  end

  def allowed_roles
    %w[sadmin admin]
  end
end
