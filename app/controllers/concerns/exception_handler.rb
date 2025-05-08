# frozen_string_literal: true

# :nodoc:
module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveModel::UnknownAttributeError, with: :argument_error
    rescue_from ActiveRecord::RecordNotUnique, with: :duplicate
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_record
    rescue_from ActiveRecord::StatementInvalid, with: :invalid_statement
    rescue_from PolicyException, with: :forbidden
    rescue_from ArgumentError, with: :argument_error
    rescue_from NoMethodError, with: :locked
    rescue_from NotImplementedError, with: :not_implemented
  end

  def duplicate(exception)
    message = exception.message.split('DETAIL:').try(:last).try(:strip) || 'unprocessable_entity'
    json_response(response: { success: false, message: message }, status: :unprocessable_entity)
  end

  def not_found(exception)
    message = exception.message || 'Not Found'
    json_response(response: { success: false, message: message }, status: :not_found)
  end

  def forbidden(invalid)
    json_response(response: { success: false, message: invalid.to_s || 'Forbidden', data: {} }, status: :forbidden)
  end

  def locked(message)
    json_response(response: { success: false, message: message || 'Unable to access to asked resources', data: {} },
                  status: :locked)
  end

  def argument_error(invalid)
    json_response(response: { success: false, message: invalid.to_s, data: {} }, status: :unprocessable_entity)
  end

  def invalid_record(exception)
    message = exception.message || 'Invalid database operation'
    json_response(response: { success: false, message: message, data: {} }, status: :unprocessable_entity)
  end

  def invalid_statement(exception)
    message = exception.message || 'Invalid database operation'
    json_response(response: { success: false, message: message, data: {} }, status: :unprocessable_entity)
  end

  def not_implemented(exception)
    message = exception.message || 'Not implemented'
    json_response(response: { success: false, message: message, data: {} }, status: :not_implemented)
  end

  private

  # :nodoc:
  def json_response(response:, status: :ok)
    Rails.logger.debug(response.inspect) if Rails.env.development?
    render(json: response, status: status)
  end
end
