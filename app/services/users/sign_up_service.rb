# frozen_string_literal: true

class Users::SignUpService
  attr_accessor :enterprise, :data

  def initialize(enterprise:, data:)
    @enterprise = enterprise
    @data = data
  end

  def call
    ActiveRecord::Base.transaction do
      user = User.create!(allowed_data)

      create_user_enterprise.call(user)

      user.generate_active_token!

      create_user_role(user).call

      UsersMailer.verifier_account(user: user, enterprise: enterprise).deliver_now!

      user
    end
  end

  private

  def allowed_data
    data[:token] = SecureRandom.uuid
    data
  end

  def create_user_enterprise
    ::UserEnterprises::Create.new(enterprise: enterprise)
  end

  def create_user_role(user)
    ::UserRoles::OwnerAdmin::Create.new(user: user)
  end
end
