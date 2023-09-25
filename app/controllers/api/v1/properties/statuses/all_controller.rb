# frozen_string_literal: true

class Api::V1::Properties::Statuses::AllController < ApplicationController

  # GET  /:enterprise_subdomain/v1/properties/statuses/all
  def index
    render json: { success: true, data: Status.all_of_properties(language) }
  end
end
