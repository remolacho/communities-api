# frozen_string_literal: true

class Api::V1::Enterprises::SettingController < ApplicationController

  # GET /:enterprise_subdomain/v1/enterprise/setting?lang=es
  def index
    render json: { success: true,
                   data: ::Enterprises::SettingSerializer.new(enterprise).as_json }
  end
end
