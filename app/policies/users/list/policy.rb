# frozen_string_literal: true

class Users::List::Policy < ::BasePolicy
  attr_accessor :petition, :status

  def initialize(current_user:, enterprise:)
    super(current_user: current_user)

    @enterprise = enterprise
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
    %w[sadmin admin manager]
  end
end
