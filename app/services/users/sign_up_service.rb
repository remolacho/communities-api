# frozen_string_literal: true

class Users::SignUpService
  attr_accessor :enterprise, :data

  def initialize(enterprise:, data:)
    @enterprise = enterprise
    @data = data
  end

  def call
    user = User.create!(allowed_data)
    enterprise.user_enterprises.create!(user_id: user.id)

    user.generate_active_token!

    UsersMailer.verifier_account(user: user, enterprise: enterprise).deliver_now!

    user
  end

  private

  def allowed_data
    data[:token] = SecureRandom.uuid
    data
  end
end
