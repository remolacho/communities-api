# frozen_string_literal: true

module Api
  module V1
    module Properties
      module Import
        # GET /api/v1/properties/import/template
        class TemplateController < ApplicationController
          def index
            policy.can_read!

            result = service.call
            send_data result.file.to_stream.read, filename: result.name_file
          end

          private

          def policy
            @policy ||= ::Properties::Policy.new(current_user: current_user)
          end

          def service
            @service ||= ::Properties::Template::CreateService.new(user: current_user)
          end
        end
      end
    end
  end
end
