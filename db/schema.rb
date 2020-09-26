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

ActiveRecord::Schema.define(version: 2020_09_26_172309) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "value"
    t.string "gender"
    t.string "g_case"
    t.boolean "definite"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "english"
    t.boolean "negation"
  end

  create_table "buckets", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "level", default: 0
    t.bigint "verb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_buckets_on_user_id"
    t.index ["verb_id"], name: "index_buckets_on_verb_id"
  end

  create_table "edicts", force: :cascade do |t|
    t.string "value"
    t.string "english"
    t.bigint "exercice_id"
    t.string "hide_index", array: true
    t.index ["exercice_id"], name: "index_edicts_on_exercice_id"
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
    t.string "hide_index", array: true
    t.string "structure"
    t.boolean "edicted", default: false
  end

  create_table "nouns", force: :cascade do |t|
    t.string "value"
    t.string "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "english"
    t.string "kind"
  end

  create_table "prepositions", force: :cascade do |t|
    t.string "value"
    t.string "g_case"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "english"
    t.string "verbs", array: true
    t.string "kind_nouns", array: true
  end

  create_table "progress_trackers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "counter"
  end

  create_table "pronouns", force: :cascade do |t|
    t.string "value"
    t.string "person"
    t.string "g_case"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "english"
    t.string "kind"
    t.string "gender"
  end

  create_table "sentences", force: :cascade do |t|
    t.string "value"
    t.string "english"
    t.integer "word_indexes", array: true
    t.bigint "user_id"
    t.bigint "exercice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "streak"
    t.integer "session_counter"
    t.string "atomizable_type"
    t.bigint "atomizable_id"
    t.string "previous_value"
    t.index ["atomizable_type", "atomizable_id"], name: "index_sentences_on_atomizable_type_and_atomizable_id"
    t.index ["exercice_id"], name: "index_sentences_on_exercice_id"
    t.index ["user_id"], name: "index_sentences_on_user_id"
  end

  create_table "structure_elements", force: :cascade do |t|
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "element_id"
    t.index ["element_id"], name: "index_structure_elements_on_element_id"
  end

  create_table "trials", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "exercice_id"
    t.bigint "sentence_id"
    t.bigint "verb_id"
    t.integer "result"
    t.index ["exercice_id"], name: "index_trials_on_exercice_id"
    t.index ["sentence_id"], name: "index_trials_on_sentence_id"
    t.index ["user_id"], name: "index_trials_on_user_id"
    t.index ["verb_id"], name: "index_trials_on_verb_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "photo"
    t.integer "successes_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "verb_noun_links", force: :cascade do |t|
    t.bigint "noun_id"
    t.bigint "verb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["noun_id"], name: "index_verb_noun_links_on_noun_id"
    t.index ["verb_id"], name: "index_verb_noun_links_on_verb_id"
  end

  create_table "verbs", force: :cascade do |t|
    t.string "value"
    t.string "person"
    t.string "preterit"
    t.string "g_case"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "english"
    t.string "go_with", array: true
  end

  add_foreign_key "buckets", "users"
  add_foreign_key "buckets", "verbs"
  add_foreign_key "structure_elements", "elements"
  add_foreign_key "trials", "exercices"
  add_foreign_key "trials", "sentences"
  add_foreign_key "trials", "users"
  add_foreign_key "trials", "verbs"
  add_foreign_key "verb_noun_links", "nouns"
  add_foreign_key "verb_noun_links", "verbs"
end
