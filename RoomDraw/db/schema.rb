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

ActiveRecord::Schema.define(version: 20151030232612) do

  create_table "collections", force: :cascade do |t|
    t.integer  "suite_num",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "draw_groups", force: :cascade do |t|
    t.integer  "student_id", limit: 4
    t.decimal  "draw_num",             precision: 10, scale: 5
    t.boolean  "for_suite"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "draw_groups", ["student_id"], name: "rep_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.integer  "draw_group_id", limit: 4
    t.integer  "student_id",    limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "members", ["draw_group_id", "student_id"], name: "index_members_on_draw_group_id_and_student_id", unique: true, using: :btree
  add_index "members", ["student_id"], name: "student_id", using: :btree

  create_table "occupies", force: :cascade do |t|
    t.integer  "student_id",    limit: 4
    t.integer  "room_id",       limit: 4
    t.string   "dorm_name",     limit: 255
    t.string   "room_num",      limit: 255
    t.integer  "academic_year", limit: 4
    t.boolean  "in_fall?"
    t.boolean  "in_spring?"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "occupies", ["room_id"], name: "fk_rails_95d84e3073", using: :btree
  add_index "occupies", ["student_id"], name: "fk_rails_4a9d76a866", using: :btree

  create_table "requests", force: :cascade do |t|
    t.integer  "draw_group_id", limit: 4
    t.integer  "collection_id", limit: 4
    t.decimal  "rank_absolute",           precision: 10
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "requests", ["collection_id"], name: "fk_rails_7d23987a4b", using: :btree
  add_index "requests", ["draw_group_id"], name: "fk_rails_6a394ae907", using: :btree
  add_index "requests", ["rank_absolute"], name: "index_requests_on_rank_absolute", unique: true, using: :btree

  create_table "rooms", force: :cascade do |t|
    t.string   "dorm_name",     limit: 255
    t.string   "room_num",      limit: 255
    t.integer  "capacity",      limit: 4
    t.integer  "collection_id", limit: 4,   null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "rooms", ["collection_id"], name: "fk_rails_c704d37356", using: :btree
  add_index "rooms", ["dorm_name", "room_num"], name: "index_rooms_on_dorm_name_and_room_num", unique: true, using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "draw_num",   limit: 4
    t.integer  "grad_year",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "students", ["draw_num"], name: "index_students_on_draw_num", unique: true, using: :btree

  create_table "users", id: false, force: :cascade do |t|
    t.string   "student_id",      limit: 255, null: false
    t.string   "password_digest", limit: 255, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "users", ["student_id"], name: "index_users_on_student_id", unique: true, using: :btree

  add_foreign_key "draw_groups", "students", name: "rep_id"
  add_foreign_key "members", "draw_groups", name: "group_id", on_delete: :cascade
  add_foreign_key "members", "students", name: "student_id", on_delete: :cascade
  add_foreign_key "occupies", "rooms"
  add_foreign_key "occupies", "students"
  add_foreign_key "requests", "collections", on_delete: :cascade
  add_foreign_key "requests", "draw_groups", on_delete: :cascade
  add_foreign_key "rooms", "collections"
end
