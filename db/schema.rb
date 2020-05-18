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

ActiveRecord::Schema.define(version: 2020_05_18_201022) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.integer "igdb_id"
    t.string "name"
    t.text "description"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "covers", force: :cascade do |t|
    t.string "url"
    t.integer "width"
    t.integer "height"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "igdb_id"
    t.string "igdb_image_id"
    t.index ["game_id"], name: "index_covers_on_game_id"
  end

  create_table "game_collection_items", force: :cascade do |t|
    t.bigint "game_collection_id"
    t.bigint "game_id"
    t.bigint "platform_id"
    t.boolean "is_borrowed"
    t.money "cost", scale: 2
    t.text "note_text"
    t.boolean "is_private_note"
    t.boolean "has_cart_disk_item"
    t.boolean "has_case_box"
    t.boolean "has_manual"
    t.boolean "has_other_items"
    t.index ["game_collection_id"], name: "index_game_collection_items_on_game_collection_id"
    t.index ["game_id"], name: "index_game_collection_items_on_game_id"
    t.index ["platform_id"], name: "index_game_collection_items_on_platform_id"
  end

  create_table "game_collections", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_game_collections_on_user_id"
  end

  create_table "game_developers", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_game_developers_on_company_id"
    t.index ["game_id"], name: "index_game_developers_on_game_id"
  end

  create_table "game_mode_items", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "game_mode_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_mode_items_on_game_id"
    t.index ["game_mode_id"], name: "index_game_mode_items_on_game_mode_id"
  end

  create_table "game_modes", force: :cascade do |t|
    t.integer "igdb_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_platforms", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "platform_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_platforms_on_game_id"
    t.index ["platform_id"], name: "index_game_platforms_on_platform_id"
  end

  create_table "game_publishers", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_game_publishers_on_company_id"
    t.index ["game_id"], name: "index_game_publishers_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "release_date"
    t.integer "igdb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
  end

  create_table "jwt_blacklist", force: :cascade do |t|
    t.string "jti", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "multiplayer_modes", force: :cascade do |t|
    t.boolean "offline_coop"
    t.boolean "online_coop"
    t.boolean "lan_coop"
    t.boolean "campaign_coop"
    t.boolean "splitscreen_online"
    t.boolean "splitscreen"
    t.boolean "drop_in"
    t.integer "offline_coop_max"
    t.integer "online_coop_max"
    t.integer "online_max"
    t.integer "offline_max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "game_id"
    t.bigint "platform_id"
    t.index ["game_id"], name: "index_multiplayer_modes_on_game_id"
    t.index ["platform_id"], name: "index_multiplayer_modes_on_platform_id"
  end

  create_table "platforms", force: :cascade do |t|
    t.string "name"
    t.integer "igdb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "game_collection_items", "game_collections"
  add_foreign_key "game_collection_items", "games"
  add_foreign_key "game_collection_items", "platforms"
  add_foreign_key "game_collections", "users"
  add_foreign_key "game_developers", "companies"
  add_foreign_key "game_developers", "games"
  add_foreign_key "game_mode_items", "game_modes"
  add_foreign_key "game_mode_items", "games"
  add_foreign_key "game_platforms", "games"
  add_foreign_key "game_platforms", "platforms"
  add_foreign_key "game_publishers", "companies"
  add_foreign_key "game_publishers", "games"
end
