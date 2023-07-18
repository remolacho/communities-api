# frozen_string_literal: true

class Users::SignInService

  attr_accessor :email, :password

  def initialize(email:, password:)
    @email = email
    @password = password
  end

  def call
    validate_sign_in

    current_user
  end

  private

  def validate_sign_in
    raise PolicyException.new(I18n.t('services.users.sign_in.not_found')) unless user.present?
    raise PolicyException.new(I18n.t('services.users.sign_in.not_valid')) unless valid?
    raise PolicyException.new(I18n.t('services.users.sign_in.inactive')) unless active?
  end

  def valid?
    current_user
  end

  def active?
    current_user.user_enterprise.active
  end

  def current_user
    @current_user ||= user.authenticate(password)
  end

  def user
    @user ||= User.find_by(email: email)
  end
end
