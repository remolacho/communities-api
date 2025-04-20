# frozen_string_literal: true

module BaseZero
  class CreateEnterpriseService
    attr_reader :tenant, :enterprise_params, :reference_regex

    def initialize(tenant, enterprise_params)
      @tenant = tenant
      @enterprise_params = enterprise_params
      @reference_regex = enterprise_params[:reference_regex] || generate_reference_regex
    end

    def call
      create_enterprise
    end

    private

    def create_enterprise
      Enterprise.find_or_create_by!(token: tenant.token, subdomain: tenant.subdomain) do |enterprise|
        enterprise.name = enterprise_params[:name]
        enterprise.social_reason = enterprise_params[:social_reason]
        enterprise.identifier = enterprise_params[:identifier]
        enterprise.short_name = generate_short_name
        enterprise.email = enterprise_params[:email]
        enterprise.reference_regex = reference_regex
      end
    end

    def generate_reference_regex
      '^T[0-4]-P(1[0-6]|[1-9])-A((10[1-8])|(20[1-8])|(30[1-8])|(40[1-8])|(50[1-8])|(60[1-8])|(70[1-8])|(80[1-8])|(90[1-8])|(100[1-8])|(110[1-8])|(120[1-8])|(130[1-8])|(140[1-8])|(150[1-8])|(160[1-8]))$'
    end

    def generate_short_name
      enterprise_params[:name].split.map(&:first).join.upcase
    end
  end
end
