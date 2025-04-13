# frozen_string_literal: true

module Api
  module V1
    module Users
      class UploadAvatarController < ApplicationController
        # POST /:enterprise_subdomain/v1/users/upload_avatar
        def create
          service = ::Users::UploadAvatar.new(user: current_user, avatar_file: allowed_params)

          render json: { success: service.perform, message: I18n.t('services.users.sign_up.avatar.success') }
        end

        private

        def allowed_params
          @allowed_params ||= params[:avatar_file]
        end
      end
    end
  end
end
