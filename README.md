# Communities API

## Configuración Técnica

### Requisitos del Sistema

* Ruby version
  `- ruby 3.2.2`

* System dependencies
  - rails 7
  - postgres
  - rspec

### Configuración Inicial

* Configuration
  - bundle install
  - change application.example.yml to application.yml

* Database creation
  - rake db:create
  - rake db:create RAILS_ENV=test

* Database initialization
  - rake db:migrate
  - rake db:migrate RAILS_ENV=test

### Testing y Documentación

* How to run the test suite
  - rails rswag:specs:swaggerize (runner the test and create documentation)
  - rails g rspec:swagger namespace::controller_name
  - rspec

* Documentation
  - generate rake rswag:specs:swaggerize
  - http://localhost:3000/api-docs

* Frontend template
  - https://github.com/coreui/coreui-free-react-admin-template

## Implementación para una nueva empresa

### 1. Configuración Inicial

Para inicializar una nueva empresa con la configuración estándar, ejecute:

```bash
rake base_zero:help
```

Este comando creará una nueva empresa con la configuración predeterminada, incluyendo:
- Estados (Status)
- Tipos de Propiedades (PropertyTypes)
- Tipos de Propietarios (PropertyOwnerTypes)
- Roles y Grupos de Roles
- Configuraciones básicas de PQRs

### 2. Puntos de Personalización

#### 2.1 Estados (Status)
Los estados pueden ser personalizados según las necesidades de la empresa

#### 2.2 Tipos de Propiedades (PropertyTypes)
Cada tipo de propiedad puede ser personalizado con:
- Nombre
- Patrón de localización (regex)
- Placeholder

#### 2.3 Tipos de propietarios (PropertyOwnerType)
Personalice los nombres de los tipos de propietarios

#### 2.4 Grupos de Roles (GroupRoles)
Los grupos de roles son cruciales para la privacidad de los PQRs:


#### 2.5 Roles
Personalice los roles según la estructura organizacional

* Deployment instructions


* Documentation
  - generate rake rswag:specs:swaggerize
  - http://localhost:3000/api-docs
* ...

* Frontend template
  - https://github.com/coreui/coreui-free-react-admin-template
* ...
