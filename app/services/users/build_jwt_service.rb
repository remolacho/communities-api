# frozen_string_literal: true

class Users::BuildJwtService
  include AuthJwtGo

  attr_accessor :user, :quantity, :unit, :prefix

  def initialize(user:, quantity: 1, unit: 'd')
    @user = user
    @prefix = 'Bearer'.freeze
    @quantity = quantity
    @unit = unit
  end

  def build
    sign_jwt
  rescue StandardError
    raise PolicyException.new(I18n.t('services.users.sign_in.jwt_error'))
  end

  private

  def sign_jwt
    data = payload.merge!({ exp: generate_exp })
    "#{prefix} #{encode_token(data).dig(:jwt)}"
  end

  def payload
    {
      api: 'Community API',
      checksum: create_checksum
    }.merge!(user_attributes)
  end

  def user_attributes
    {
      token: user.token,
      name: user.name,
      lastname: user.lastname,
      email: user.email,
      subdomain: enterprise.subdomain
    }
  end

  def create_checksum
    Digest::SHA1.hexdigest(Digest::MD5.hexdigest("#{user.id}-#{enterprise.subdomain}-#{user.email}"))
  end

  def generate_exp
    (Time.now + eval("#{quantity.to_i}.#{symbol}")).to_i
  end

  def symbol
    return acronym.pluralize if quantity.to_i > 1

    acronym
  end

  def acronym
    @acronym ||= acronyms[unit]
  end

  def acronyms
    {
      'S' => 'second',
      'M' => 'minute',
      'H' => 'hour',
      'd' => 'day',
      'm' => 'month',
      'y' => 'year'
    }
  end

  def enterprise
    @enterprise ||= user.enterprise
  end
end
