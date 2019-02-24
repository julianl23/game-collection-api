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

ActiveRecord::Schema.define(version: 2019_02_19_022701) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.integer "igdb_id"
    t.string "name"
    t.text "description"
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "covers", force: :cascade do |t|
    t.string "url"
    t.string "cloudinary_id"
    t.integer "width"
    t.integer "height"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_covers_on_game_id"
  end

  create_table "game_collections", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_collections_on_game_id"
    t.index ["user_id"], name: "index_game_collections_on_user_id"
  end

  create_table "game_modes", force: :cascade do |t|
    t.integer "igdb_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "release_date"
    t.integer "igdb_id"
    t.bigint "developer_id"
    t.bigint "publisher_id"
    t.bigint "game_mode_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "platform_id"
    t.bigint "multiplayer_mode_id"
    t.bigint "cover_id"
    t.index ["cover_id"], name: "index_games_on_cover_id"
    t.index ["developer_id"], name: "index_games_on_developer_id"
    t.index ["game_mode_id"], name: "index_games_on_game_mode_id"
    t.index ["multiplayer_mode_id"], name: "index_games_on_multiplayer_mode_id"
    t.index ["platform_id"], name: "index_games_on_platform_id"
    t.index ["publisher_id"], name: "index_games_on_publisher_id"
  end

  create_table "multiplayer_modes", force: :cascade do |t|
    t.bigint "platform_id"
    t.bigint "game_id"
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
    t.string "email"
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "game_collections", "games"
  add_foreign_key "game_collections", "users"
end
