# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_07_180838) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "value"
    t.string "gender"
    t.string "case"
    t.boolean "definite"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "english"
  end

  create_table "elements", force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exercices", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "structure_id"
    t.index ["structure_id"], name: "index_exercices_on_structure_id"
  end

  create_table "nouns", force: :cascade do |t|
    t.string "value"
    t.string "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "english"
  end

  create_table "personal_pronouns", force: :cascade do |t|
    t.string "value"
    t.string "person"
    t.string "case"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "english"
  end

  create_table "progress_trackers", force: :cascade do |t|
    t.string "counter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "exercice_id"
    t.bigint "user_id"
    t.index ["exercice_id"], name: "index_progress_trackers_on_exercice_id"
    t.index ["user_id"], name: "index_progress_trackers_on_user_id"
  end

  create_table "structure_elements", force: :cascade do |t|
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "element_id"
    t.bigint "structure_id"
    t.index ["element_id"], name: "index_structure_elements_on_element_id"
    t.index ["structure_id"], name: "index_structure_elements_on_structure_id"
  end

  create_table "structures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "verbs", force: :cascade do |t|
    t.string "value"
    t.string "person"
    t.string "preterit"
    t.string "g_case"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "english"
  end

  add_foreign_key "exercices", "structures"
  add_foreign_key "progress_trackers", "exercices"
  add_foreign_key "progress_trackers", "users"
  add_foreign_key "structure_elements", "elements"
  add_foreign_key "structure_elements", "structures"
end
