# frozen_string_literal: true

module Users
  class UploadAvatar
    attr_accessor :user, :avatar_file

    def initialize(user:, avatar_file:)
      @user = user
      @avatar_file = avatar_file
    end

    def perform
      raise ArgumentError, I18n.t('services.users.sign_up.avatar.nil') if avatar_file.nil?

      user.avatar.attach(avatar_file)
      user.avatar.attached?
    end
  end
end
