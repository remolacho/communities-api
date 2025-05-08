# frozen_string_literal: true

# rake base_zero:help
# rake "base_zero:init[altos-de-berlin,Altos de Berlin,123456789,admin@altosdeberlin.com, CO]"

# enterprise_params = {
#   subdomain: altos-de-berlin,
#   name: 'Altos de Berlin',
#   identifier: '123456789',
#   email: 'admin@altosdeberlin.com',
#   reference_regex: '^T[0-4]-P(1[0-6]|[1-9])-A((10[1-8])|(20[1-8])|(30[1-8])|(40[1-8])|(50[1-8])|(60[1-8])|(70[1-8])|(80[1-8])|(90[1-8])|(100[1-8])|(110[1-8])|(120[1-8])|(130[1-8])|(140[1-8])|(150[1-8])|(160[1-8]))$'
#   country_code: 'CO'
# }
namespace :base_zero do
  desc 'Initialize Base Zero with enterprise parameters. Example: rake base_zero:init[subdomain,social_reason,identifier,email,country_code]'
  task :init, [:subdomain, :social_reason, :identifier, :email, :country_code] => :environment do |_task, args|
    unless args[:subdomain] && args[:social_reason] && args[:identifier] && args[:email] && args[:country_code]
      raise ArgumentError,
            'Missing required parameters. Usage: rake base_zero:init[subdomain,social_reason,identifier,email,country_code]'
    end

    begin
      puts 'Starting Base Zero initialization from Rake task...'

      tenant_params = {
        social_reason: args[:social_reason],
        subdomain: args[:subdomain],
        name: args[:social_reason],
        identifier: args[:identifier],
        email: args[:email],
        reference_regex: generate_reference_regex,
        country_code: args[:country_code]
      }

      facade = BaseZero::Facade.new(tenant_params)
      facade.create

      puts 'Base Zero initialization completed successfully!'
    rescue StandardError => e
      puts "Error during Base Zero initialization: #{e.message}"
      raise
    end
  end

  private

  def generate_reference_regex
    '^T[0-4]-P(1[0-6]|[1-9])-A((10[1-8])|(20[1-8])|(30[1-8])|(40[1-8])|(50[1-8])|(60[1-8])|(70[1-8])|(80[1-8])|(90[1-8])|(100[1-8])|(110[1-8])|(120[1-8])|(130[1-8])|(140[1-8])|(150[1-8])|(160[1-8]))$'
  end

  desc 'List all available Base Zero commands and their usage'
  task :help do
    puts <<~HELP
      Available Base Zero commands:

      rake base_zero:init[subdomain,social_reason,identifier,email]
        Initialize a new Base Zero instance with the given parameters

        Parameters:
          subdomain - The subdomain for the enterprise (e.g., 'altos-de-berlin')
          social_reason     - The social_reason of the enterprise (e.g., 'Altos de Berlin')
          identifier      - The identifier number (e.g., '123456789')
          email    - The admin email (e.g., 'admin@example.com')

        Example:
          rake base_zero:init['altos-de-berlin','Altos de Berlin','123456789','admin@altosdeberlin.com']
    HELP
  end
end
