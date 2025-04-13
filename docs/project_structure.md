# Estructura del Proyecto - Communities API

## Visión General de la Estructura
El proyecto sigue la estructura estándar de Ruby on Rails con algunas personalizaciones para mejor organización y mantenibilidad.

## Directorios Principales

### `/app`
Contiene el código principal de la aplicación:
- `/controllers` - Controladores de la API
- `/models` - Modelos de datos y lógica de negocio
- `/services` - Servicios para encapsular lógica compleja
- `/serializers` - Serializadores para las respuestas JSON de la API
- `/policies` - Políticas de autorización
- `/views` - Vistas (limitadas al ser una API)

### `/config`
Configuraciones del proyecto:
- `database.yml` - Configuración de base de datos
- `routes.rb` - Definición de rutas de la API
- `application.rb` - Configuración principal de la aplicación
- Otros archivos de configuración del entorno

### `/db`
Gestión de base de datos:
- `/migrate` - Migraciones de la base de datos
  - Usuarios y roles
  - Sistema de PQRs
  - Propiedades y atributos
  - Sistema multi-tenant
- `schema.rb` - Esquema actual de la base de datos
- `/seeds` - Datos iniciales

### `/spec`
Tests y especificaciones:
- `/models` - Tests de modelos
- `/controllers` - Tests de controladores
- `/services` - Tests de servicios
- `/swagger` - Especificaciones de API para Swagger

### `/swagger`
Documentación de la API:
- Archivos de especificación OpenAPI/Swagger
- Documentación interactiva de endpoints

### `/lib`
Código reutilizable y tareas personalizadas:
- Módulos compartidos
- Tareas Rake personalizadas
- Utilidades generales

### `/public`
Archivos públicos:
- Assets estáticos
- Archivos de error personalizados
- Documentación pública

### `/docs`
Documentación del proyecto:
- `business_context.md` - Contexto y visión del negocio
- `project_structure.md` - Este documento
- Documentación adicional del proyecto

### `/bin`
Scripts y ejecutables:
- `rails` - Ejecutable de Rails
- `setup` - Script de configuración
- `bundle` - Ejecutable de Bundler
- Otros scripts de utilidad

### `/storage`
Almacenamiento de archivos:
- Archivos subidos por usuarios
- Archivos temporales
- Backups

### `/vendor`
Código de terceros:
- Gemas personalizadas
- Assets de terceros
- Dependencias modificadas

### Archivos en la Raíz

#### Configuración
- `Gemfile` - Dependencias del proyecto
- `Gemfile.lock` - Versiones específicas de dependencias
- `.ruby-version` - Versión de Ruby
- `.rubocop.yml` - Reglas de estilo de código
- `.rspec` - Configuración de tests
- `.gitignore` - Archivos ignorados por Git

#### Despliegue
- `Dockerfile` - Configuración de contenedor
- `.dockerignore` - Archivos ignorados en build de Docker
- `fly.toml` - Configuración de despliegue en Fly.io

#### Otros
- `README.md` - Documentación principal
- `Rakefile` - Tareas automatizadas
- `config.ru` - Configuración del servidor Rack

## Convenciones de Código
- Seguimos las convenciones estándar de Ruby on Rails
- Utilizamos RuboCop para mantener consistencia en el estilo
- Los tests son obligatorios para nuevas funcionalidades
- La documentación Swagger se genera automáticamente de los tests

## Notas de Desarrollo
- El proyecto utiliza una arquitectura modular para facilitar expansiones futuras
- Implementamos un sistema multi-tenant para manejar múltiples comunidades
- La estructura está diseñada para escalar horizontalmente
- Mantenemos separación clara entre la lógica de negocio y la capa de presentación
