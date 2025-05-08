# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2025_04_28_020119) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "answers_petitions", force: :cascade do |t|
    t.bigint "petition_id", null: false
    t.bigint "user_id", null: false
    t.string "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["petition_id"], name: "index_answers_petitions_on_petition_id"
    t.index ["user_id"], name: "index_answers_petitions_on_user_id"
  end

  create_table "category_fines", force: :cascade do |t|
    t.string "name"
    t.string "code", null: false
    t.bigint "enterprise_id", null: false
    t.bigint "created_by_id", null: false
    t.boolean "active", default: true, null: false
    t.string "formula"
    t.float "value"
    t.string "description"
    t.bigint "parent_category_fine_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_category_fines_on_code"
    t.index ["created_by_id"], name: "index_category_fines_on_created_by_id"
    t.index ["enterprise_id", "code"], name: "index_category_fines_on_enterprise_id_and_code", unique: true
    t.index ["enterprise_id"], name: "index_category_fines_on_enterprise_id"
    t.index ["parent_category_fine_id"], name: "index_category_fines_on_parent_category_fine_id"
  end

  create_table "category_petitions", force: :cascade do |t|
    t.bigint "enterprise_id", null: false
    t.string "name", null: false
    t.string "slug", null: false
    t.integer "parent_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enterprise_id"], name: "index_category_petitions_on_enterprise_id"
    t.index ["parent_category_id"], name: "index_category_petitions_on_parent_category_id"
    t.index ["slug"], name: "index_category_petitions_on_slug", unique: true
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "currency_code", null: false
    t.string "currency_symbol", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_countries_on_code", unique: true
    t.index ["name"], name: "index_countries_on_name", unique: true
  end

  create_table "enterprises", force: :cascade do |t|
    t.bigint "country_id", null: false
    t.string "identifier", null: false
    t.string "document_type", default: "NIT", null: false
    t.string "social_reason", null: false
    t.string "placeholder_reference", default: "T4-P11-A1102", null: false
    t.string "token", null: false
    t.string "subdomain", null: false
    t.string "email", null: false
    t.string "reference_regex"
    t.string "name", null: false
    t.string "short_name", null: false
    t.string "address"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_enterprises_on_country_id"
    t.index ["email"], name: "index_enterprises_on_email", unique: true
    t.index ["subdomain"], name: "index_enterprises_on_subdomain", unique: true
    t.index ["token"], name: "index_enterprises_on_token", unique: true
  end

  create_table "entity_permissions", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.string "entity_type", null: false
    t.boolean "can_read", default: false
    t.boolean "can_write", default: false
    t.boolean "can_destroy", default: false
    t.boolean "can_change_status", default: false
    t.jsonb "custom_permissions", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id", "entity_type"], name: "index_entity_permissions_on_role_id_and_entity_type", unique: true
    t.index ["role_id"], name: "index_entity_permissions_on_role_id"
  end

  create_table "fines", force: :cascade do |t|
    t.bigint "status_id", null: false
    t.bigint "user_id", null: false
    t.bigint "property_id", null: false
    t.bigint "category_fine_id", null: false
    t.string "token", null: false
    t.string "ticket", null: false
    t.string "title", null: false
    t.string "message", null: false
    t.string "fine_type", null: false
    t.float "value", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_fine_id"], name: "index_fines_on_category_fine_id"
    t.index ["property_id"], name: "index_fines_on_property_id"
    t.index ["status_id"], name: "index_fines_on_status_id"
    t.index ["ticket"], name: "index_fines_on_ticket", unique: true
    t.index ["token"], name: "index_fines_on_token", unique: true
    t.index ["user_id"], name: "index_fines_on_user_id"
  end

  create_table "follow_petitions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "petition_id"
    t.bigint "status_id"
    t.string "observation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["petition_id"], name: "index_follow_petitions_on_petition_id"
    t.index ["status_id"], name: "index_follow_petitions_on_status_id"
    t.index ["user_id"], name: "index_follow_petitions_on_user_id"
  end

  create_table "group_role_relations", force: :cascade do |t|
    t.bigint "group_role_id", null: false
    t.bigint "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_role_id", "role_id"], name: "index_group_role_relations_on_group_role_id_and_role_id", unique: true
    t.index ["group_role_id"], name: "index_group_role_relations_on_group_role_id"
    t.index ["role_id"], name: "index_group_role_relations_on_role_id"
  end

  create_table "group_roles", force: :cascade do |t|
    t.string "code", null: false
    t.jsonb "name", default: {}, null: false
    t.string "entity_type", default: "petitions", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code", "entity_type"], name: "index_group_roles_on_code_and_entity_type", unique: true
  end

  create_table "petitions", force: :cascade do |t|
    t.string "token", null: false
    t.string "ticket", null: false
    t.string "title", null: false
    t.string "message", null: false
    t.bigint "status_id", null: false
    t.bigint "user_id", null: false
    t.bigint "category_petition_id", null: false
    t.bigint "group_role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_petition_id"], name: "index_petitions_on_category_petition_id"
    t.index ["group_role_id"], name: "index_petitions_on_group_role_id"
    t.index ["status_id"], name: "index_petitions_on_status_id"
    t.index ["ticket"], name: "index_petitions_on_ticket", unique: true
    t.index ["token"], name: "index_petitions_on_token", unique: true
    t.index ["user_id"], name: "index_petitions_on_user_id"
  end

  create_table "properties", force: :cascade do |t|
    t.bigint "enterprise_id", null: false
    t.bigint "property_type_id", null: false
    t.bigint "status_id", null: false
    t.string "location", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enterprise_id"], name: "index_properties_on_enterprise_id"
    t.index ["property_type_id", "location"], name: "index_properties_on_property_type_id_and_location", unique: true
    t.index ["property_type_id"], name: "index_properties_on_property_type_id"
    t.index ["status_id"], name: "index_properties_on_status_id"
  end

  create_table "property_owner_types", force: :cascade do |t|
    t.bigint "enterprise_id", null: false
    t.string "code", null: false
    t.string "name", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_property_owner_types_on_code", unique: true
    t.index ["enterprise_id"], name: "index_property_owner_types_on_enterprise_id"
  end

  create_table "property_types", force: :cascade do |t|
    t.bigint "enterprise_id", null: false
    t.string "code", null: false
    t.string "name", null: false
    t.boolean "active", default: true, null: false
    t.string "location_regex", null: false
    t.string "placeholder", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_property_types_on_code", unique: true
    t.index ["enterprise_id"], name: "index_property_types_on_enterprise_id"
  end

  create_table "roles", force: :cascade do |t|
    t.jsonb "name", null: false
    t.string "code", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_roles_on_code", unique: true
    t.index ["slug"], name: "index_roles_on_slug", unique: true
  end

  create_table "statuses", force: :cascade do |t|
    t.jsonb "name", null: false
    t.string "code", null: false
    t.string "status_type", null: false
    t.string "color", default: "#E8E6E6"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_statuses_on_code", unique: true
  end

  create_table "suggestions", force: :cascade do |t|
    t.string "token", null: false
    t.string "ticket", null: false
    t.string "message", null: false
    t.boolean "read", default: false
    t.boolean "anonymous", default: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket"], name: "index_suggestions_on_ticket", unique: true
    t.index ["token"], name: "index_suggestions_on_token", unique: true
    t.index ["user_id"], name: "index_suggestions_on_user_id"
  end

  create_table "tenants", force: :cascade do |t|
    t.string "subdomain"
    t.string "token", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subdomain"], name: "index_tenants_on_subdomain", unique: true
    t.index ["token"], name: "index_tenants_on_token", unique: true
  end

  create_table "user_enterprises", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "enterprise_id", null: false
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enterprise_id"], name: "index_user_enterprises_on_enterprise_id"
    t.index ["user_id", "enterprise_id"], name: "index_user_enterprises_on_user_id_and_enterprise_id", unique: true
    t.index ["user_id"], name: "index_user_enterprises_on_user_id"
  end

  create_table "user_properties", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "property_id", null: false
    t.bigint "property_owner_type_id", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_user_properties_on_property_id"
    t.index ["property_owner_type_id"], name: "index_user_properties_on_property_owner_type_id"
    t.index ["user_id", "property_id"], name: "index_user_properties_on_user_id_and_property_id", unique: true
    t.index ["user_id"], name: "index_user_properties_on_user_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.boolean "active", default: true
    t.integer "created_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_user_roles_on_user_id_and_role_id", unique: true
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "document_type", default: "CC", null: false
    t.string "name", null: false
    t.string "lastname", null: false
    t.string "token", null: false
    t.string "email", null: false
    t.string "reference"
    t.string "password_digest", null: false
    t.string "lang", default: "es", null: false
    t.string "reset_password_key"
    t.datetime "reset_password_key_expires_at"
    t.string "active_key"
    t.datetime "active_key_expires_at"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active_key"], name: "index_users_on_active_key", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["identifier"], name: "index_users_on_identifier", unique: true
    t.index ["reference"], name: "index_users_on_reference"
    t.index ["reset_password_key"], name: "index_users_on_reset_password_key", unique: true
    t.index ["token"], name: "index_users_on_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "category_fines", "enterprises"
  add_foreign_key "category_fines", "users", column: "created_by_id"
  add_foreign_key "entity_permissions", "roles"
  add_foreign_key "properties", "enterprises"
  add_foreign_key "properties", "property_types"
  add_foreign_key "properties", "statuses"
  add_foreign_key "property_owner_types", "enterprises"
  add_foreign_key "property_types", "enterprises"
  add_foreign_key "user_properties", "properties"
  add_foreign_key "user_properties", "property_owner_types"
  add_foreign_key "user_properties", "users"
end
