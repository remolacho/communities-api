class ApplicationController < ActionController::API
  include AuthJwtGo
  include ExceptionHandler
  include Translatable

  before_action :authorized_user
  before_action :set_language
  before_action :valid_subdomain!
  before_action :valid_user_active!

  def valid_subdomain!
    raise PolicyException unless params[:enterprise_subdomain].eql?(current_user.enterprise.subdomain)
  end

  def valid_user_active!
    raise PolicyException, I18n.t('services.users.sign_in.inactive') unless current_user.active?
  end

  private

  def enterprise
    @enterprise ||= Enterprise.find_by!(subdomain: params[:enterprise_subdomain])
  end
end
