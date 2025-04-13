# frozen_string_literal: true

module Users
  class SignUpService
    attr_accessor :enterprise, :data

    MAX_REFERENCE = 2

    def initialize(enterprise:, data:)
      @enterprise = enterprise
      @data = data
    end

    def call
      ActiveRecord::Base.transaction do
        valid_reference!

        user = User.create!(allowed_data)

        create_user_enterprise.call(user)

        user.generate_active_token!

        create_user_role(user).call

        user
      end
    end

    private

    def valid_reference!
      return unless enterprise.reference_regex.present?

      regex = Regexp.new(enterprise.reference_regex)

      unless data[:reference].present?
        raise ActiveRecord::RecordNotFound,
              I18n.t('services.users.sign_up.validation.error.reference.empty')
      end
      unless data[:reference].match(regex)
        raise ActiveRecord::RecordNotFound,
              I18n.t('services.users.sign_up.validation.error.reference.format')
      end
      return unless record_user_limit >= MAX_REFERENCE

      raise ActiveRecord::RecordNotFound,
            I18n.t('services.users.sign_up.validation.error.reference.limit',
                   limit: MAX_REFERENCE)
    end

    def record_user_limit
      User.where(reference: data[:reference]).count
    end

    def allowed_data
      data[:token] = SecureRandom.uuid

      data
    end

    def create_user_enterprise
      ::UserEnterprises::Create.new(enterprise: enterprise)
    end

    def create_user_role(user)
      ::UserRoles::OwnerAdmin::Create.new(user: user)
    end
  end
end
