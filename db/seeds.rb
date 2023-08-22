tenancy = Tenant.find_or_initialize_by(subdomain: "altos-de-berlin")
tenancy.update!(token: SecureRandom.uuid) if tenancy.new_record?

Apartment::Tenant.switch!(tenancy.subdomain)

enterprise = Enterprise.find_or_create_by(token: tenancy.token, subdomain: tenancy.subdomain) do |e|
  e.name =  "Altos de Berlin"
  e.rut = "1110602918"
  e.short_name = "alt".upcase
  e.email = "jonathangrh.25@gamil.com"
  e.reference_regex = "^T[0-4]-P(1[0-6]|[1-9])-A((10[1-8])|(20[1-8])|(30[1-8])|(40[1-8])|(50[1-8])|(60[1-8])|(70[1-8])|(80[1-8])|(90[1-8])|(100[1-8])|(110[1-8])|(120[1-8])|(130[1-8])|(140[1-8])|(150[1-8])|(160[1-8]))$"
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
  { code: 'all', name: {es: "Todas los miembros"}, entity_type: 'petitions' },
  { code: 'adminmanager', name: {es: "Solo Administración y Presidente"}, entity_type: 'petitions' },
  { code: 'all_admin', name: {es: "Solo Administración"}, entity_type: 'petitions' },
  { code: 'admincomi', name: {es: "Solo Administración y Comité"}, entity_type: 'petitions' },
  { code: 'admincon', name: {es: "Solo Administración y Consejo"}, entity_type: 'petitions' },
  { code: 'concomi', name: {es: "Solo Consejo y Comité"}, entity_type: 'petitions' },
  { code: 'admin', name: {es: "Sólo Administrador"}, entity_type: 'petitions' },
  { code: 'comi', name: {es: "Sólo Comité"}, entity_type: 'petitions' },
  { code: 'con', name: {es: "Sólo Consejo"}, entity_type: 'petitions' },
  { code: 'fiscal', name: {es: "Sólo Fiscal"}, entity_type: 'petitions' },
  { code: 'counter', name: {es: "Sólo Contador"}, entity_type: 'petitions' },
  { code: 'listed_suggestions', name: {es: "Pueden listar las sugerencias"}, entity_type: 'suggestions' },
  { code: 'show_suggestion', name: {es: "Pueden ver las sugerencias"}, entity_type: 'suggestions' },
  { code: 'listed_users', name: {es: "Pueden listar los usuarios del sistema"}, entity_type: 'users' },
  { code: 'show_user', name: {es: "Pueden ver el perfil de un usuario"}, entity_type: 'users' },
  { code: 'change_status_user', name: {es: "Pueden cambiar el estado de un usuario"}, entity_type: 'users' },
  { code: 'edit_enterprise', name: {es: "Pueden editar los datos de la empresa"}, entity_type: 'enterprises' },
  { code: 'show_enterprise', name: {es: "Pueden ver los datos de la empresa"}, entity_type: 'enterprises' },
  { code: 'assign_user_roles', name: {es: "Puede asignar roles a los usuarios"}, entity_type: 'user_roles' },
  { code: 'remove_user_roles', name: {es: "Puede remover roles a los usuarios"}, entity_type: 'user_roles' },
]

group_roles.each do |gp|
  GroupRole.find_or_create_by(code: gp[:code], entity_type:  gp[:entity_type]) do |g|
    g.name = gp[:name]
  end
end

group_roles_relations = {
  petitions: {
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
  },
  suggestions: {
    listed_suggestions: [:sadmin, :admin, :manager],
    show_suggestion: [:sadmin, :admin, :manager]
  },
  users: {
    listed_users: [:sadmin, :admin, :manager],
    show_user: [:sadmin, :admin, :manager],
    change_status_user: [:sadmin, :admin]
  },
  enterprises: {
    edit_enterprise: [:sadmin, :admin],
    show_enterprise: [:sadmin, :admin]
  },
  user_roles: {
    assign_user_roles: [:sadmin, :admin],
    remove_user_roles: [:sadmin, :admin]
  }
}

group_roles_relations.each do |type, group_role|
  group_role.each do |code, rs|
    roles = Role.where(code: rs)
    group = GroupRole.find_by(code: code, entity_type: type)

    roles.each do |r|
      GroupRoleRelation.find_or_create_by(role_id: r.id, group_role_id: group.id)
    end
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