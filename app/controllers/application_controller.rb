class ApplicationController < ActionController::API
  include AuthJwtGo
  include ExceptionHandler
  include Translatable

  before_action :authorized_user
  before_action :set_language
  before_action :valid_subdomain!

  def valid_subdomain!
    raise PolicyException unless params[:enterprise_subdomain].eql?(current_user.enterprise.subdomain)
  end
end
