tenancy = Tenant.find_or_initialize_by(subdomain: "altos-de-berlin")
tenancy.update!(token: SecureRandom.uuid) if tenancy.new_record?

Apartment::Tenant.switch!(tenancy.subdomain)

enterprise = Enterprise.find_or_create_by(token: tenancy.token, subdomain: tenancy.subdomain) do |e|
  e.name =  "Altos de Berlin"
  e.rut = "1110602918"
  e.short_name = "alt".upcase
end

roles = {
  sadmin: "Super admin",
  admin:  "admin",
  oamin:  "Owner admin",
  owner:  "Owner",
  convi:  "Coexistence Member",
  comite: "Committee Member",
  counter: "counter",
  fiscal: "fiscal",
  manager: "President/Manager",
  collaborator: "Collaborator",
  tenant: "tenant"
}

roles.each do |k, v|
  Role.find_or_create_by!(code: k ,slug: v.parameterize, name: v)
end

group_roles = [
  { code: 'all', name: {es: "Todas los miembros"} },
  { code: 'adminmanager', name: {es: "Solo Administración y Presidente"} },
  { code: 'all_admin', name: {es: "Solo Administración"} },
  { code: 'admincomi', name: {es: "Solo Administración y Comité"} },
  { code: 'admincon', name: {es: "Solo Administración y Consejo"} },
  { code: 'concomi', name: {es: "Solo Consejo y Comité"} },
  { code: 'admin', name: {es: "Sólo Administrador"} },
  { code: 'comi', name: {es: "Sólo Comité"} },
  { code: 'con', name: {es: "Sólo Consejo"} },
  { code: 'fiscal', name: {es: "Sólo Fiscal"} },
  { code: 'counter', name: {es: "Sólo Contador"} }
]

group_roles.each do |gp|
  GroupRole.find_or_create_by(code: gp[:code]) do |g|
    g.name = gp[:name]
  end
end

group_roles_relations = {
  all: [:sadmin, :admin, :convi, :comite, :manager, :counter, :fiscal],
  all_admin: [:sadmin, :admin, :counter, :fiscal],
  adminmanager: [:sadmin, :admin, :manager],
  admincomi: [:sadmin, :admin, :comite],
  admincon: [:sadmin, :admin, :convi],
  concomi: [:sadmin, :convi, :comite],
  admin: [:sadmin, :admin],
  comi: [:sadmin, :comite],
  con: [:sadmin, :convi],
  fiscal: [:sadmin, :fiscal],
  counter: [:sadmin, :counter]
}

group_roles_relations.each do |k, v|
  roles = Role.where(code: v)
  group = GroupRole.find_by(code: k)
  roles.each do |r|
    GroupRoleRelation.find_or_create_by(role_id: r.id, group_role_id: group.id)
  end
end

statuses = [
    { name: {es: "Pendiente", en: "Pending"}, code: Status::PETITION_PENDING, status_type: Status::PETITION, color: '#D6EAF3'},
    { name: {es: "En revisión", en: "In review"}, code: Status::PETITION_REVIEWING, status_type: Status::PETITION, color: '#7AC6EB'},
    { name: {es: "Rechazada", en: "Rejected"}, code: Status::PETITION_REJECTED, status_type: Status::PETITION, color: '#F0553B'},
    { name: {es: "Confirmar solución", en: "Confirm solution"}, code: Status::PETITION_CONFIRM, status_type: Status::PETITION,color: '#3B8FF0'},
    { name: {es: "Resuelta", en: "Resolve"}, code: Status::PETITION_RESOLVE, status_type: Status::PETITION, color: '#8BE939'},
    { name: {es: "Rechazo de la solución", en: "Rejected solution"}, code: Status::PETITION_REJECTED_SOLUTION, status_type: Status::PETITION, color: '#F6FB43'},
    { name: {es: "Respuesta eliminada", en: "Answer destroy"}, code: Status::ANSWER_DELETE, status_type: Status::ANSWER},
]

statuses.each do |status|
  Status.find_or_create_by!(status)
end

categories_petition_parent = [
  { name: "Petición", slug: "Petición".parameterize, enterprise_id: enterprise.id },
  { name: "Queja", slug: "Queja".parameterize, enterprise_id: enterprise.id },
  { name: "Reclamo", slug: "Reclamo".parameterize, enterprise_id: enterprise.id },
  { name: "Agresiones", slug: "agresiones".parameterize, enterprise_id: enterprise.id }
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
  u.reference = 'T4-P11-A1102'
  u.phone = '3174131149'
end

UserEnterprise.find_or_create_by!(user_id: user.id, enterprise_id: enterprise.id, active: true)
UserRole.find_or_create_by!(user_id: user.id, role_id: Role.find_by!(code: 'sadmin').id, created_by: user.id)
UserRole.find_or_create_by!(user_id: user.id, role_id: Role.find_by!(code: 'owner').id, created_by: user.id)