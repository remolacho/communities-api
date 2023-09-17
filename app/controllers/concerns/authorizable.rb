# rubocop:disable all
# frozen_string_literal: true

module Authorizable
  extend ActiveSupport::Concern
  include AuthJwtGo

  included do
    before_action :switch_tenant!
    before_action :authorized_user
    before_action :valid_subdomain!
    before_action :valid_user_active!
  end

  def switch_tenant!
    Apartment::Tenant.switch!(params[:enterprise_subdomain])
  rescue StandardError
    raise PolicyException, I18n.t('services.enterprises.subdomain.invalid')
  end

  def valid_subdomain!
    raise PolicyException unless params[:enterprise_subdomain].eql?(current_user.enterprise.subdomain)
  end

  def valid_user_active!
    raise PolicyException, I18n.t('services.users.sign_in.inactive') unless current_user.active?
  end
end
