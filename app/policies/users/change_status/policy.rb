# frozen_string_literal: true

class Users::ChangeStatus::Policy < ::BasePolicy
  attr_accessor :enterprise

  def initialize(current_user:, enterprise:)
    super(current_user: current_user)

    @enterprise = enterprise
  end

  def can_write!
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
