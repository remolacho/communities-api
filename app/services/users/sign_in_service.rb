# frozen_string_literal: true

class Users::SignInService

  attr_accessor :email, :password

  def initialize(email:, password:)
    @email = email
    @password = password
  end

  def call
    validate_sign_in

    response.new(current_user, jwt_token)
  end

  private

  def validate_sign_in
    raise PolicyException.new(I18n.t('services.users.sign_in.not_found')) unless user.present?
    raise PolicyException.new(I18n.t('services.users.sign_in.not_valid')) unless valid?
    raise PolicyException.new(I18n.t('services.users.sign_in.inactive')) unless active?
    raise PolicyException.new(I18n.t('services.users.sign_in.jwt_error')) unless  jwt_token.present?
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

  def jwt_token
    @jwt_token ||= ::Users::BuildJwtService.new(user: current_user).call
  end

  def response
    Struct.new(:user, :jwt)
  end
end
