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

ActiveRecord::Schema.define(version: 20150110065336) do

  create_table "candidate_details", force: true do |t|
    t.integer  "candidate_id"
    t.integer  "kind"
    t.string   "sns_link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "candidate_details", ["candidate_id"], name: "index_candidate_details_on_candidate_id", using: :btree

  create_table "candidate_memos", force: true do |t|
    t.integer  "candidate_id", null: false
    t.string   "name"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "candidate_memos", ["candidate_id"], name: "index_candidate_memos_on_candidate_id", using: :btree

  create_table "candidate_progresses", force: true do |t|
    t.integer  "candidate_id"
    t.datetime "sent_at"
    t.datetime "replied_at"
    t.datetime "meeting_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "candidate_progresses", ["candidate_id"], name: "index_candidate_progresses_on_candidate_id", using: :btree

  create_table "candidates", force: true do |t|
    t.string   "name",         default: "",  null: false
    t.integer  "country_id"
    t.integer  "city_id"
    t.integer  "kind"
    t.string   "personal_url"
    t.integer  "phone"
    t.string   "email"
    t.string   "image"
    t.string   "status"
    t.string   "probability",  default: "0", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "candidates", ["country_id", "city_id"], name: "index_candidates_on_country_id_and_city_id", using: :btree

  create_table "cities", force: true do |t|
    t.integer  "country_id",              null: false
    t.string   "title",      default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["country_id"], name: "index_cities_on_country_id", using: :btree

  create_table "countries", force: true do |t|
    t.string   "title",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
