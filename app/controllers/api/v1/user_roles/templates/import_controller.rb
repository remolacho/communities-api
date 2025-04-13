# frozen_string_literal: true

module Api
  module V1
    module UserRoles
      module Templates
        class ImportController < ApplicationController
          skip_before_action :authorized_user, :valid_subdomain!, :valid_user_active!

          # GET /:enterprise_subdomain/v1/user_roles/templates/import
          def index
            service = UserRoles::Templates::ImportService.new(enterprise: enterprise)
            result = service.build

            send_data result.file.to_stream.read, filename: result.name_file
          end
        end
      end
    end
  end
end
