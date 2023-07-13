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

enterprise = Enterprise.find_or_create_by(token: tenancy.token, subdomain: tenancy.subdomain) do |e|
  e.name =  "Altos de Berlin"
  e.rut = "1110602918"
end

roles = {
  sadmin: "Super admin",
  admin:  "admin",
  oamin:  "Owner admin",
  owner:  "Owner",
  convi:  "Coexistence Member",
  comite: "Committee Member"
}

roles.each do |k, v|
  Role.find_or_create_by!(code: k ,slug: v.parameterize, name: v)
end

statuses = [
    { name: {es: "Pendiente", en: "Pending"}, code: "pet-pending", status_type: 'petition'},
    { name: {es: "En revisión", en: "In review"}, code: "pet-inReview", status_type: 'petition'},
    { name: {es: "Confirmar solución", en: "Confirm solution"}, code: "pet-confirm", status_type: 'petition'},
    { name: {es: "Resuelta", en: "Resolve"}, code: "pet-resolve", status_type: 'petition'},
    { name: {es: "Confirmación rechazada", en: "Confirmation rejected"}, code: "pet-rejected", status_type: 'petition'},
    { name: {es: "Rechazada", en: "Rejected"}, code: "pet-cancel", status_type: 'petition'},
]

statuses.each do |status|
  Status.find_or_create_by!(status)
end

categories_petition_parent = [
  { name: "Petición", slug: "Petición".parameterize, enterprise_id: enterprise.id },
  { name: "Queja", slug: "Queja".parameterize, enterprise_id: enterprise.id },
  { name: "Reclamo", slug: "Reclamo".parameterize, enterprise_id: enterprise.id }
]

categories_petition_parent.each do |category|
  CategoryPetition.find_or_create_by!(category)
end

user = User.find_or_create_by(email: 'jonathangrh.25@gmail.com') do |u|
  u.identifier = '1110602918'
  u.name = 'Jonathan'
  u.lastname = 'Rojas'
  u.token = SecureRandom.uuid
  u.password = '@admin.83'
  u.password_confirmation = '@admin.83'
end

UserEnterprise.find_or_create_by!(user_id: user.id, enterprise_id: enterprise.id, active: true)
UserRole.find_or_create_by!(user_id: user.id, role_id: Role.find_by!(code: 'sadmin').id)
UserRole.find_or_create_by!(user_id: user.id, role_id: Role.find_by!(code: 'owner').id)

group_petitions = [
  { code: 'all', name: {es: "Todas las partes"} },
  { code: 'admincomi', name: {es: "Administración y Comité"} },
  { code: 'admincon', name: {es: "Administración y Consejo"} },
  { code: 'concomi', name: {es: "Consejo y Comité"} },
  { code: 'admin', name: {es: "Sólo Administración"} },
  { code: 'comi', name: {es: "Sólo Comité"} },
  { code: 'con', name: {es: "Sólo Consejo"} }
]

group_codes = group_petitions.map do |gp|
  group = GroupPetition.find_or_create_by(code: gp[:code]) do |g|
    g.name = gp[:name]
  end

  group.code
end