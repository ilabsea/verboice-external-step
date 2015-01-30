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

ActiveRecord::Schema.define(version: 20150130045841) do

  create_table "ilo_ratings", force: true do |t|
    t.date     "from_date"
    t.date     "to_date"
    t.text     "numbers"
    t.integer  "code"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instances", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "end_point"
    t.boolean  "default",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operators", force: true do |t|
    t.string   "name"
    t.integer  "code"
    t.text     "prefixes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "operators", ["name"], name: "index_operators_on_name", unique: true, using: :btree

  create_table "step_variables", force: true do |t|
    t.string   "name"
    t.string   "display_name"
    t.text     "description"
    t.string   "kind"
    t.string   "direction"
    t.integer  "step_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "steps", force: true do |t|
    t.string   "name"
    t.string   "display_name"
    t.text     "description"
    t.string   "icon",         default: "medicalkit"
    t.string   "kind",         default: "callback"
    t.text     "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

end
