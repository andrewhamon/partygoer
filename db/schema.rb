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

ActiveRecord::Schema.define(version: 20180417021013) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "cube"
  enable_extension "earthdistance"

  create_table "parties", force: :cascade do |t|
    t.bigint "owner_id", null: false
    t.string "name", null: false
    t.float "lat", null: false
    t.float "lng", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "ll_to_earth(lat, lng)", name: "index_parties_on_ll_to_earth_lat_lng", using: :gist
    t.index ["owner_id"], name: "index_parties_on_owner_id"
  end

  create_table "spotify_users", force: :cascade do |t|
    t.string "sid", null: false
    t.string "device_id"
    t.string "token", null: false
    t.string "token_expires_at", null: false
    t.string "refresh_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sid"], name: "index_spotify_users_on_sid", unique: true
  end

  create_table "submissions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "track_id", null: false
    t.bigint "party_id", null: false
    t.integer "score", default: 0, null: false
    t.datetime "played_at"
    t.datetime "skipped_at"
    t.boolean "playing", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["party_id"], name: "index_submissions_on_party_id"
    t.index ["played_at"], name: "index_submissions_on_played_at"
    t.index ["playing"], name: "index_submissions_on_playing"
    t.index ["score"], name: "index_submissions_on_score"
    t.index ["skipped_at"], name: "index_submissions_on_skipped_at"
    t.index ["track_id"], name: "index_submissions_on_track_id"
    t.index ["user_id", "track_id", "party_id"], name: "index_submissions_on_user_id_and_track_id_and_party_id", unique: true
    t.index ["user_id"], name: "index_submissions_on_user_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "sid", null: false
    t.jsonb "metadata", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sid"], name: "index_tracks_on_sid", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "token", null: false
    t.float "lat"
    t.float "lng"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "current_party_id"
    t.bigint "spotify_user_id"
    t.index "ll_to_earth(lat, lng)", name: "index_users_on_ll_to_earth_lat_lng", using: :gist
    t.index ["current_party_id"], name: "index_users_on_current_party_id"
    t.index ["spotify_user_id"], name: "index_users_on_spotify_user_id"
    t.index ["token"], name: "index_users_on_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "submission_id", null: false
    t.integer "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["submission_id"], name: "index_votes_on_submission_id"
    t.index ["user_id", "submission_id"], name: "index_votes_on_user_id_and_submission_id", unique: true
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "parties", "users", column: "owner_id"
  add_foreign_key "submissions", "parties"
  add_foreign_key "submissions", "tracks"
  add_foreign_key "submissions", "users"
  add_foreign_key "users", "parties", column: "current_party_id"
  add_foreign_key "users", "spotify_users"
  add_foreign_key "votes", "submissions"
  add_foreign_key "votes", "users"
end
