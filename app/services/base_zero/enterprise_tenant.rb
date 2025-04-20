# frozen_string_literal: true

module BaseZero
  class EnterpriseTenant
    attr_reader :subdomain, :tenancy

    def initialize(subdomain:)
      @subdomain = subdomain
      @tenancy = Tenant.find_or_initialize_by(subdomain: subdomain)
    end

    def create
      tenancy.update!(token: SecureRandom.uuid) if tenancy.new_record?
      tenancy
    end
  end
end
