# frozen_string_literal: true

module BaseZero
  class Facade
    attr_reader :enterprise_params

    def initialize(enterprise_params)
      @enterprise_params = enterprise_params
    end

    def create
      ActiveRecord::Base.transaction do
        puts "\n=== Starting Base Zero initialization ===\n\n"
        tenant = BaseZero::EnterpriseTenant.new(subdomain: enterprise_params[:subdomain]).create
        puts "✓ Created tenant: #{tenant.subdomain}"

        puts '• Creating countries...'
        BaseZero::CreateCountriesService.new.call
        country = Country.find_by!(code: enterprise_params[:country_code])
        puts '✓ Created countries'

        puts '• Switching to tenant schema...'
        Apartment::Tenant.switch!(tenant.subdomain)
        puts "✓ Switched to tenant schema: #{Apartment::Tenant.current}"

        enterprise = BaseZero::CreateEnterpriseService.new(tenant, enterprise_params, country).call
        puts "✓ Created enterprise: #{enterprise.name}"

        puts "\n=== Creating base components ===\n"
        puts '• Creating base roles...'
        BaseZero::CreateRolesService.new.call

        puts '• Creating base group roles...'
        BaseZero::CreateGroupRolesService.new.call

        puts '• Creating group role relations...'
        BaseZero::CreateGroupRoleRelationsService.new.call

        puts '• Creating base statuses...'
        BaseZero::CreateStatusesService.new.call

        puts "\n=== Creating tenant specific components ===\n"
        puts '• Creating category petitions...'
        BaseZero::CreateCategoriesPetitionsService.new(enterprise).create

        puts '• Creating admin user with roles...'
        BaseZero::CreateUserAdminService.new(enterprise).create

        puts '• Creating entity permissions...'
        BaseZero::CreateEntityPermissionsService.new.call

        puts '• Creating property types...'
        BaseZero::CreatePropertyTypesService.new(enterprise).call

        puts '• Creating property owner types...'
        BaseZero::CreatePropertyOwnerTypesService.new(enterprise).call

        puts "\n✓ Base Zero initialization completed successfully!\n"
      end
    rescue StandardError => e
      puts "\n❌ Error during Base Zero initialization: #{e.message}"
      puts "\nBacktrace:"
      puts e.backtrace
      raise
    end
  end
end
