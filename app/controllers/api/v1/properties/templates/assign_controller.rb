class Api::V1::Properties::Templates::AssignController < ApplicationController
  skip_before_action :authorized_user, :valid_subdomain!, :valid_user_active!

  # GET /:enterprise_subdomain/v1/properties/templates/assign
  def index
    service = ::Properties::Templates::AssignService.new(enterprise: enterprise)
    result = service.build

    send_data result.file.to_stream.read, filename: result.name_file
  end
end
