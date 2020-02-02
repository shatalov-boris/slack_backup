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

ActiveRecord::Schema.define(version: 2020_02_02_185051) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "channel_members", id: :serial, force: :cascade do |t|
    t.integer "channel_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id", "user_id"], name: "index_channel_members_on_channel_id_and_user_id", unique: true
    t.index ["channel_id"], name: "index_channel_members_on_channel_id"
    t.index ["user_id"], name: "index_channel_members_on_user_id"
  end

  create_table "channels", id: :serial, force: :cascade do |t|
    t.text "name", null: false
    t.text "topic"
    t.text "purpose"
    t.string "slack_id", null: false
    t.string "creator_slack_id", null: false
    t.integer "channel_type", null: false
    t.integer "status", null: false
    t.datetime "latest_crawled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "messages_count", default: 0
    t.integer "team_id"
    t.integer "users_count", default: 0
    t.index ["channel_type"], name: "index_channels_on_channel_type"
    t.index ["name"], name: "index_channels_on_name"
    t.index ["slack_id"], name: "index_channels_on_slack_id"
    t.index ["status"], name: "index_channels_on_status"
    t.index ["team_id"], name: "index_channels_on_team_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "channel_id"
    t.integer "message_type", null: false
    t.boolean "hidden"
    t.text "text", null: false
    t.datetime "ts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_messages_on_channel_id"
    t.index ["message_type"], name: "index_messages_on_message_type"
    t.index ["ts"], name: "index_messages_on_ts"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "pghero_query_stats", force: :cascade do |t|
    t.text "database"
    t.text "user"
    t.text "query"
    t.bigint "query_hash"
    t.float "total_time"
    t.bigint "calls"
    t.datetime "captured_at"
    t.index ["database", "captured_at"], name: "index_pghero_query_stats_on_database_and_captured_at"
  end

  create_table "pghero_space_stats", force: :cascade do |t|
    t.text "database"
    t.text "schema"
    t.text "relation"
    t.bigint "size"
    t.datetime "captured_at"
    t.index ["database", "captured_at"], name: "index_pghero_space_stats_on_database_and_captured_at"
  end

  create_table "reactions", id: :serial, force: :cascade do |t|
    t.integer "message_id", null: false
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "users_count", default: 0
    t.index ["message_id"], name: "index_reactions_on_message_id"
    t.index ["name"], name: "index_reactions_on_name"
  end

  create_table "teams", id: :serial, force: :cascade do |t|
    t.string "slack_id", default: "", null: false
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_teams_on_name", unique: true
  end

  create_table "user_reactions", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "reaction_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reaction_id"], name: "index_user_reactions_on_reaction_id"
    t.index ["user_id", "reaction_id"], name: "index_user_reactions_on_user_id_and_reaction_id", unique: true
    t.index ["user_id"], name: "index_user_reactions_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "username", default: "", null: false
    t.string "first_name", default: ""
    t.string "last_name", default: ""
    t.string "slack_access_token", default: ""
    t.string "slack_id", default: "", null: false
    t.string "avatar", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "team_id"
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.string "provider"
    t.string "uid"
    t.string "slug"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["team_id"], name: "index_users_on_team_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "channel_members", "channels", name: "channel_members_channel_id_fk"
  add_foreign_key "channel_members", "users", name: "channel_members_user_id_fk"
  add_foreign_key "channels", "teams", name: "channels_team_id_fk"
  add_foreign_key "messages", "channels", name: "messages_channel_id_fk"
  add_foreign_key "messages", "users", name: "messages_user_id_fk"
  add_foreign_key "reactions", "messages", name: "reactions_message_id_fk"
  add_foreign_key "user_reactions", "reactions", name: "user_reactions_reaction_id_fk"
  add_foreign_key "user_reactions", "users", name: "user_reactions_user_id_fk"
  add_foreign_key "users", "teams", name: "users_team_id_fk"
end
