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

ActiveRecord::Schema[7.0].define(version: 2023_07_14_184915) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "enterprises", force: :cascade do |t|
    t.string "rut", null: false
    t.string "token", null: false
    t.string "subdomain", null: false
    t.string "name", null: false
    t.string "address"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rut"], name: "index_enterprises_on_rut", unique: true
    t.index ["subdomain"], name: "index_enterprises_on_subdomain", unique: true
    t.index ["token"], name: "index_enterprises_on_token", unique: true
  end

  create_table "group_petition_roles", force: :cascade do |t|
    t.bigint "group_petition_id", null: false
    t.bigint "role_id", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_petition_id", "role_id"], name: "index_group_petition_roles_on_group_petition_id_and_role_id", unique: true
    t.index ["group_petition_id"], name: "index_group_petition_roles_on_group_petition_id"
    t.index ["role_id"], name: "index_group_petition_roles_on_role_id"
  end

  create_table "group_petitions", force: :cascade do |t|
    t.string "code", null: false
    t.jsonb "name", default: {}, null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_group_petitions_on_code", unique: true
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_statuses_on_code", unique: true
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

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_user_roles_on_user_id_and_role_id", unique: true
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "name", null: false
    t.string "lastname", null: false
    t.string "token", null: false
    t.string "email", null: false
    t.string "address"
    t.string "password_digest", null: false
    t.string "lang", default: "es", null: false
    t.string "reset_password_key"
    t.datetime "reset_password_key_expires_at"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["identifier"], name: "index_users_on_identifier", unique: true
    t.index ["reset_password_key"], name: "index_users_on_reset_password_key", unique: true
    t.index ["token"], name: "index_users_on_token", unique: true
  end

end
