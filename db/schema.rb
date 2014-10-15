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

ActiveRecord::Schema.define(version: 20141015082621) do

  create_table "devices", force: true do |t|
    t.string   "session"
    t.string   "fingerprint"
    t.string   "http_accept"
    t.string   "http_accept_language"
    t.string   "http_accept_encoding"
    t.string   "http_dnt"
    t.string   "http_user_agent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "devices", ["fingerprint"], name: "index_devices_on_fingerprint"
  add_index "devices", ["session"], name: "index_devices_on_session"

  create_table "shortened_urls", force: true do |t|
    t.string   "full_url"
    t.string   "url_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shortened_urls", ["url_hash"], name: "index_shortened_urls_on_url_hash"

  create_table "visits", force: true do |t|
    t.integer  "shortened_url_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remote_addr"
    t.string   "http_referer"
    t.integer  "device_id"
  end

  add_index "visits", ["device_id"], name: "index_visits_on_device_id"
  add_index "visits", ["shortened_url_id"], name: "index_visits_on_shortened_url_id"

end
