# frozen_string_literal: true

class Users::SignUpService
  attr_accessor :enterprise, :data

  MAX_ADDRESS = 2

  def initialize(enterprise:, data:)
    @enterprise = enterprise
    @data = data
  end

  def call
    ActiveRecord::Base.transaction do
      valid_address!

      user = User.create!(allowed_data)

      create_user_enterprise.call(user)

      user.generate_active_token!

      create_user_role(user).call

      user
    end
  end

  private

  def valid_address!
    regex = /\A(T[0-4], P(0?[0-9]|1[0-6]), A([0-8]{1,4}|1608))\z/

    raise ActiveRecord::RecordNotFound, I18n.t("services.users.sign_up.validation.error.address.empty")  unless data[:address].present?
    raise ActiveRecord::RecordNotFound, I18n.t("services.users.sign_up.validation.error.address.format") unless data[:address].match(regex)
    raise ActiveRecord::RecordNotFound, I18n.t("services.users.sign_up.validation.error.address.limit", limit: MAX_ADDRESS) if record_user_limit >= MAX_ADDRESS
  end

  def record_user_limit
    User.where(address: data[:address]).count
  end

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
