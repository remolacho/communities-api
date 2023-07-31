# frozen_string_literal: true

class UserRoles::Import::CreateService
  attr_accessor :file, :user, :enterprise

  def initialize(enterprise:, user:, file:)
    @enterprise = enterprise
    @user = user
    @file = file
  end

  def perform
    raise ArgumentError, I18n.t('services.user_roles.import.create.file_nil') unless file.present?
  end
end
