# frozen_string_literal: true

module BaseZero
  class CreateUserAdminService
    def initialize(enterprise)
      @enterprise = enterprise
    end

    def create
      return false unless @enterprise

      ActiveRecord::Base.transaction do
        create_user_with_roles
      end
      true
    rescue StandardError => e
      Rails.logger.error("Error creating admin user: #{e.message}")
      false
    end

    private

    def create_user_with_roles
      user = create_user
      create_user_enterprise(user)
      create_user_roles(user, user_data[:roles])
    end

    def user_data
      {
        email: 'jonathangrh.25@gmail.com',
        identifier: '1110602918',
        name: 'Jonathan',
        lastname: 'Rojas',
        password: '@admin.83',
        reference: 'T4-P11-A1102',
        phone: '3174131149',
        roles: ['super_admin', 'owner']
      }
    end

    def create_user
      User.find_or_create_by!(email: user_data[:email]) do |u|
        u.identifier = user_data[:identifier]
        u.name = user_data[:name]
        u.lastname = user_data[:lastname]
        u.token = SecureRandom.uuid
        u.password = user_data[:password]
        u.password_confirmation = user_data[:password]
        u.reference = user_data[:reference]
        u.phone = user_data[:phone]
      end
    end

    def create_user_enterprise(user)
      UserEnterprise.find_or_create_by!(
        user_id: user.id,
        enterprise_id: @enterprise.id,
        active: true
      )
    end

    def create_user_roles(user, role_codes)
      role_codes.each do |code|
        role = Role.find_by!(code: code)
        UserRole.find_or_create_by!(
          user_id: user.id,
          role_id: role.id,
          created_by: user.id
        )
      end
    end
  end
end
