class User
  module Tokenizable
    extend ActiveSupport::Concern

    def generate_password_token!(expired)
      begin
        self.reset_password_key = SecureRandom.uuid
      end while User.exists?(reset_password_key: reset_password_key)

      self.reset_password_key_expires_at = expired
      self.save!
    end

    def generate_active_token!
      begin
        self.active_key = SecureRandom.uuid
      end while User.exists?(active_key: active_key)

      self.save!
    end
  end
end
