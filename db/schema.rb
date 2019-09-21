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

ActiveRecord::Schema.define(version: 2019_09_21_104144) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", force: :cascade do |t|
    t.string "title", null: false
    t.integer "length", null: false
    t.string "score", null: false
    t.string "image", null: false
    t.string "link", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_movies_on_user_id"
  end

  create_table "popular_movies", force: :cascade do |t|
    t.integer "tmdb_movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tmdb_movies", force: :cascade do |t|
    t.string "title"
    t.string "image"
    t.string "homepage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_recommended_movies", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "tmdb_movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tmdb_movie_id"], name: "index_user_recommended_movies_on_tmdb_movie_id"
    t.index ["user_id"], name: "index_user_recommended_movies_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "email", null: false
    t.string "filmarks_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "movies", "users"
  add_foreign_key "user_recommended_movies", "tmdb_movies"
  add_foreign_key "user_recommended_movies", "users"
end
