# frozen_string_literal: true

# :nodoc:
module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveModel::UnknownAttributeError, with: :argument_error
    rescue_from ActiveRecord::RecordNotUnique, with: :duplicate
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :not_found
    rescue_from PolicyException, with: :forbidden
    rescue_from ArgumentError, with: :argument_error
    rescue_from NoMethodError, with: :locked
  end

  def duplicate(exception)
    message = exception.message.split('DETAIL:').try(:last).try(:strip) || 'unprocessable_entity'
    json_response(response: { success: false, message: message }, status: :unprocessable_entity)
  end

  # :nodoc:
  def not_found(exception)
    message = exception.message || 'Not Found'
    json_response(response: { success: false, message: message }, status: :not_found)
  end

  # :nodoc:
  def forbidden(invalid)
    json_response(response: { success: false, message: invalid.to_s || 'Forbidden', data: {} }, status: :forbidden)
  end

  def locked(message)
    json_response(response: { success: false, message: (message || 'Unable to access to asked resources'), data: {} }, status: :locked)
  end

  # :nodoc:
  def argument_error(invalid)
    json_response(response: { success: false, message: invalid.to_s, data: {} }, status: :unprocessable_entity)
  end

  private

  # :nodoc:
  def json_response(response:, status: :ok)
    Rails.logger.debug(response.inspect) if Rails.env.development?
    render(json: response, status: status)
  end
end
