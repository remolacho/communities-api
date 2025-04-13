# frozen_string_literal: true

class Api::V1::Petitions::Statuses::AllController < ApplicationController
  # GET /:enterprise_subdomain/v1/petition/statuses/all
  def index
    render json: { success: true, data: Status.all_of_petitions(language) }
  end
end
