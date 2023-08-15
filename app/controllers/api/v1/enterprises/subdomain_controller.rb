# frozen_string_literal: true

class Api::V1::Enterprises::SubdomainController < ApplicationController
  skip_before_action :authorized_user, :valid_subdomain!, :valid_user_active!

  # GET /:enterprise_subdomain/v1/enterprise/subdomain
  def index
    render json: { success: true, message: I18n.t('services.enterprises.subdomain.valid'), data: { logo_url: enterprise.logo_url }}
  end
end
