class ApplicationController < ActionController::API
  include AuthJwtGo
  include ExceptionHandler
  include Translatable

  before_action :authorized_user
  before_action :set_language
end
