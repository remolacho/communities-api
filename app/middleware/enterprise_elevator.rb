# frozen_string_literal: true

# app/middleware/my_custom_elevator.rb
require 'apartment/elevators/subdomain'

# :nodoc:
class EnterpriseElevator < Apartment::Elevators::Subdomain
  # :nodoc:
  def call(env)
    super
  rescue StandardError
    [http_status_codes(:forbidden),
     { 'Content-Type' => 'application/json' },
     [
       {
         success: false,
         message: I18n.t('services.enterprises.subdomain.invalid')
       }.to_json
     ]]
  end

  # @return [String]
  def parse_tenant_name(request)
    request_enterprise = enterprise_subdomain(request.path, request.params)
    # If the domain acquired is set to be excluded, set the tenant to whatever is currently
    # next in line in the schema search path.

    tenant = if exclude_subdomain.include?(request_enterprise)
               nil
             else
               request_enterprise
             end

    tenant.presence
  end

  def enterprise_subdomain(path, query_params)
    segments = path.split('/').reject { |item| !item.present? }
    subdomain = segments[0]

    return subdomain unless subdomain.eql?('rails')

    query_params['enterprise_subdomain'] if subdomain.eql?('rails') && segments[1].eql?('active_storage')
  rescue StandardError
    nil
  end

  def exclude_subdomain
    self.class.excluded_subdomains = ['api-docs', 'admin', 'favicon.ico']
  end

  def http_status_codes(symbol)
    Rack::Utils::SYMBOL_TO_STATUS_CODE[symbol]
  end
end
