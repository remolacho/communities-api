# frozen_string_literal: true

class Users::ChangeStatusAccount
  attr_accessor :user, :user_to_change

  def initialize(user:, user_to_change:)
    @user = user
    @user_to_change = user_to_change
  end

  def call
    user_to_change.user_enterprise.update(active: !active)

    UsersMailer.verifier_account(user: user_to_change, enterprise: user_to_change.enterprise).deliver_now!
  end

  private

  def active
    user_to_change.active?
  end
end
