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

ActiveRecord::Schema.define(version: 20170309123151) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "channel_members", force: :cascade do |t|
    t.integer  "channel_id", null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id", "user_id"], name: "index_channel_members_on_channel_id_and_user_id", unique: true, using: :btree
    t.index ["channel_id"], name: "index_channel_members_on_channel_id", using: :btree
    t.index ["user_id"], name: "index_channel_members_on_user_id", using: :btree
  end

  create_table "channels", force: :cascade do |t|
    t.text     "name",                         null: false
    t.text     "topic"
    t.text     "purpose"
    t.string   "slack_id",                     null: false
    t.string   "creator_slack_id",             null: false
    t.integer  "channel_type",                 null: false
    t.integer  "status",                       null: false
    t.integer  "next_crawl_cycle", default: 1
    t.datetime "next_crawl_time"
    t.datetime "latest_crawled"
    t.datetime "oldest_crawled"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["channel_type"], name: "index_channels_on_channel_type", using: :btree
    t.index ["name"], name: "index_channels_on_name", using: :btree
    t.index ["slack_id"], name: "index_channels_on_slack_id", using: :btree
    t.index ["status"], name: "index_channels_on_status", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "channel_id"
    t.integer  "message_type",                null: false
    t.boolean  "hidden"
    t.text     "text",                        null: false
    t.datetime "ts"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "reactions_count", default: 0
    t.index ["channel_id"], name: "index_messages_on_channel_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "reactions", force: :cascade do |t|
    t.integer  "message_id", null: false
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_reactions_on_message_id", using: :btree
    t.index ["name"], name: "index_reactions_on_name", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string   "slack_id",   default: "", null: false
    t.string   "name",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["name"], name: "index_teams_on_name", unique: true, using: :btree
  end

  create_table "user_reactions", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "reaction_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["reaction_id"], name: "index_user_reactions_on_reaction_id", using: :btree
    t.index ["user_id", "reaction_id"], name: "index_user_reactions_on_user_id_and_reaction_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_user_reactions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",               default: "", null: false
    t.string   "username",            default: "", null: false
    t.string   "first_name",          default: ""
    t.string   "last_name",           default: ""
    t.string   "slack_access_token",  default: ""
    t.string   "slack_id",            default: "", null: false
    t.string   "avatar",              default: ""
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "team_id",                          null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "slug"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["slug"], name: "index_users_on_slug", unique: true, using: :btree
    t.index ["team_id"], name: "index_users_on_team_id", using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

end
