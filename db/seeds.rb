# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# creamos los tenants
tenancy = Tenant.find_or_initialize_by(subdomain: "altos-de-berlin")
tenancy.update!(token: SecureRandom.uuid) if tenancy.new_record?

Apartment::Tenant.switch!(tenancy.subdomain)

Enterprise.find_or_create_by!(token: tenancy.token, subdomain: tenancy.subdomain) do |enterprise|
  enterprise.name =  "Altos de Berlin"
  enterprise.rut = "1110602918"
end
