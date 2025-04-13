# frozen_string_literal: true

class Api::V1::Enterprises::SettingController < ApplicationController
  # GET /:enterprise_subdomain/v1/enterprise/setting?lang=es
  def index
    render json: {
      success: true,
      data: ::Enterprises::SettingSerializer.new(enterprise, menu: menu).as_json
    }
  end

  private

  def menu
    @menu ||= ::Menus::DecoratorService.new(user: current_user)
  end
end
