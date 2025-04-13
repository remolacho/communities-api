# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Authorizable
  include ExceptionHandler
  include Translatable

  private

  def enterprise
    @enterprise ||= Enterprise.find_by!(subdomain: params[:enterprise_subdomain])
  end
end
