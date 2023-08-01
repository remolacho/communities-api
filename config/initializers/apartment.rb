# frozen_string_literal: true

# require 'apartment/elevators/generic'
# require 'apartment/elevators/domain'
# require 'apartment/elevators/subdomain'
# require 'apartment/elevators/first_subdomain'
# require 'apartment/elevators/host'
require 'enterprise_elevator'

Apartment.configure do |config|
  config.tenant_names = -> { Tenant.pluck(:subdomain) }
  config.excluded_models = %w[Tenant]
end

Rails.application.config.middleware.use EnterpriseElevator

# Rails.application.config.middleware.use Apartment::Elevators::Domain
# Apartment::Elevators::Subdomain.excluded_subdomains = ['www']
# Rails.application.config.middleware.use Apartment::Elevators::FirstSubdomain
# Rails.application.config.middleware.use Apartment::Elevators::Host
