module Users
  module Cleanable
    extend ActiveSupport::Concern

    def clear_reset_password_key!(password, p_confirmation)
      self.password = password
      self.password_confirmation = p_confirmation
      self.reset_password_key = nil
      self.reset_password_key_expires_at = nil
      self.save!
    end

    def clear_active_key!
      self.active_key = nil
      self.save!
      self.user_enterprise.update(active: true)
    end
  end
end
