# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160104141556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bans", force: :cascade do |t|
    t.string   "format",                    null: false
    t.string   "card_name",                 null: false
    t.boolean  "restricted", default: true, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "bans", ["card_name"], name: "index_bans_on_card_name", using: :btree
  add_index "bans", ["format"], name: "index_bans_on_format", using: :btree

  create_table "card_sets", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "is_seeded"
    t.string   "code"
  end

  create_table "card_slots", force: :cascade do |t|
    t.integer  "deck_id"
    t.integer  "card_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "quantity",   default: 1,           null: false
    t.string   "location",   default: "main deck"
  end

  add_index "card_slots", ["card_id"], name: "index_card_slots_on_card_id", using: :btree
  add_index "card_slots", ["deck_id"], name: "index_card_slots_on_deck_id", using: :btree

  create_table "cards", force: :cascade do |t|
    t.string   "name",                                     null: false
    t.string   "mana_cost",                                null: false
    t.integer  "cmc",                                      null: false
    t.string   "colors",                      default: [],              array: true
    t.string   "supertypes",                  default: [],              array: true
    t.string   "types",                       default: [],              array: true
    t.string   "rarity",           limit: 50,              null: false
    t.text     "card_text",                                null: false
    t.text     "flavor_text"
    t.string   "power"
    t.string   "toughness"
    t.integer  "multiverse_id",                            null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "can_be_commander"
    t.string   "color_identity",              default: [],              array: true
    t.string   "subtypes",                    default: [],              array: true
    t.string   "type_string",                              null: false
    t.integer  "card_set_id",                              null: false
    t.string   "produces_mana",               default: [],              array: true
  end

  add_index "cards", ["name"], name: "index_cards_on_name", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",                       null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "is_keyword", default: false
    t.boolean  "is_tribal",  default: false
    t.text     "statement"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", using: :btree

  create_table "decks", force: :cascade do |t|
    t.string   "name",                        null: false
    t.string   "format",                      null: false
    t.boolean  "is_prototype", default: true
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "user_id"
    t.text     "description"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.string   "token",        null: false
    t.text     "browser_data"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "sessions", ["token"], name: "index_sessions_on_token", using: :btree
  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "taggable_type", null: false
    t.integer  "taggable_id",   null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "taggings", ["category_id", "taggable_type", "taggable_id"], name: "index_taggings_on_category_id_and_taggable_type_and_taggable_id", unique: true, using: :btree
  add_index "taggings", ["category_id"], name: "index_taggings_on_category_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",                        null: false
    t.string   "email",                           null: false
    t.string   "password_digest",                 null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "card_slots", "cards"
  add_foreign_key "card_slots", "decks"
  add_foreign_key "sessions", "users"
  add_foreign_key "taggings", "categories"
end
