# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_04_21_170743) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "results", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "song_id", null: false
    t.string "image", null: false
    t.integer "emotion", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["song_id"], name: "index_results_on_song_id"
  end

  create_table "songs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "artist", null: false
    t.string "title", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "results", "songs"
end
