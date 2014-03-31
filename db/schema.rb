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

ActiveRecord::Schema.define(version: 20140331005144) do

  create_table "match_histories", force: true do |t|
    t.integer "steam_id", limit: 8
    t.integer "match_id", limit: 8
  end

  add_index "match_histories", ["steam_id", "match_id"], name: "index_match_histories_on_steam_id_and_match_id", using: :btree

  create_table "matches", force: true do |t|
    t.integer  "match_id",      limit: 8
    t.integer  "match_seq_num"
    t.integer  "start_time"
    t.integer  "lobby_type"
    t.text     "players"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.integer  "steam_id",                 limit: 8
    t.integer  "communityvisibilitystate"
    t.integer  "profilestate"
    t.string   "personaname"
    t.string   "realname"
    t.integer  "lastlogoff"
    t.string   "profileurl"
    t.string   "avatar"
    t.string   "avatarmedium"
    t.string   "avatarfull"
    t.integer  "personastate"
    t.integer  "primaryclanid",            limit: 8
    t.integer  "timecreated"
    t.integer  "personastateflags"
    t.integer  "gameid"
    t.string   "gameserverip"
    t.integer  "gameserversteamid",        limit: 8
    t.integer  "lobbysteamid",             limit: 8
    t.string   "gameextrainfo"
    t.string   "loccountrycode"
    t.string   "locstatecode"
    t.integer  "loccityid"
    t.string   "commentpermission"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
