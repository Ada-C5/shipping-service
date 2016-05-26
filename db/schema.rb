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

ActiveRecord::Schema.define(version: 20160526213512) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "logs", force: :cascade do |t|
    t.string   "betsy_json_query"
    t.string   "betsy_json_response"
    t.string   "betsy_order_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "shipping_tables", force: :cascade do |t|
    t.string   "carrier",                                   null: false
    t.string   "origin_country",      default: "US",        null: false
    t.string   "origin_state",                              null: false
    t.string   "origin_city",                               null: false
    t.string   "origin_zip",                                null: false
    t.string   "destination_country", default: "US",        null: false
    t.string   "destination_state",                         null: false
    t.string   "destination_city",                          null: false
    t.string   "destination_zip",                           null: false
    t.float    "weight",                                    null: false
    t.float    "100.0",                                     null: false
    t.string   "dimensions",          default: "12, 12, 6", null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

end
