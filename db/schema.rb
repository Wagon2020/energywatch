# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_02_153114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appliances", force: :cascade do |t|
    t.string "appliance_type"
    t.float "energy_performance"
    t.bigint "user_id", null: false
    t.bigint "smart_home_system_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["smart_home_system_id"], name: "index_appliances_on_smart_home_system_id"
    t.index ["user_id"], name: "index_appliances_on_user_id"
  end

  create_table "consumption_entries", force: :cascade do |t|
    t.float "actual_consumption"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "consumption_type", null: false
    t.bigint "consumption_id", null: false
    t.index ["consumption_type", "consumption_id"], name: "idx_consumption"
  end

  create_table "energy_providers", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "smart_home_systems", force: :cascade do |t|
    t.string "name"
    t.string "system_type"
    t.string "username"
    t.string "password"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_smart_home_systems_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "utility_accounts", force: :cascade do |t|
    t.string "email"
    t.string "username"
    t.string "password"
    t.string "meter_ref"
    t.bigint "energy_provider_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["energy_provider_id"], name: "index_utility_accounts_on_energy_provider_id"
    t.index ["user_id"], name: "index_utility_accounts_on_user_id"
  end

  add_foreign_key "appliances", "smart_home_systems"
  add_foreign_key "appliances", "users"
  add_foreign_key "smart_home_systems", "users"
  add_foreign_key "utility_accounts", "energy_providers"
end
