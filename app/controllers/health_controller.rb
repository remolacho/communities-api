# frozen_string_literal: true

class HealthController < ApplicationController
  skip_before_action :authorized_user, :valid_subdomain!, :valid_user_active!

  # GET /health
  def index
    render(
      json: {
        platform: {
          name: Rails.configuration.application_name,
          version: ActiveRecord::Migrator.current_version,
          api_version: Rails.configuration.api_version
        }
      },
      status: :ok
    )
  end
end
