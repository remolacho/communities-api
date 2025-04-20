# rails entity_permissions:load
namespace :entity_permissions do
  desc 'Load entity permissions for all tenants'

  task load: :environment do
    puts 'Starting to load entity permissions for all tenants...'

    Tenant.find_each do |tenant|
      puts "\nSwitching to tenant: #{tenant.subdomain}"
      begin
        Apartment::Tenant.switch!(tenant.subdomain)
        BaseZero::CreateEntityPermissionsService.new.call
      rescue StandardError => e
        puts "Error loading permissions for tenant #{tenant.subdomain}: #{e.message}"
      end
    end

    puts "\nFinished loading entity permissions for all tenants!"
  end
end
