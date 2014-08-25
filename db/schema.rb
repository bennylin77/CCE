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

ActiveRecord::Schema.define(version: 20140822060948) do

  create_table "cce_class_dimensions", force: true do |t|
    t.integer  "cce_class_id"
    t.integer  "dimension_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cce_class_dimensions", ["cce_class_id"], name: "index_cce_class_dimensions_on_cce_class_id", using: :btree
  add_index "cce_class_dimensions", ["dimension_id"], name: "index_cce_class_dimensions_on_dimension_id", using: :btree

  create_table "cce_classes", force: true do |t|
    t.string   "title"
    t.string   "sub_title"
    t.integer  "kind"
    t.integer  "status"
    t.text     "introduction"
    t.text     "syllabus"
    t.text     "schedule"
    t.text     "enrollment_user"
    t.text     "future"
    t.string   "location"
    t.string   "tuition"
    t.text     "lecturers"
    t.date     "start_at"
    t.date     "end_at"
    t.text     "class_time"
    t.integer  "user_size_limits"
    t.integer  "member_id"
    t.text     "note"
    t.boolean  "verified",         default: false
    t.boolean  "available",        default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dimensions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news", force: true do |t|
    t.integer  "cce_class_id"
    t.string   "title"
    t.text     "content"
    t.integer  "view"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "news", ["cce_class_id"], name: "index_news_on_cce_class_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "extend"
    t.integer  "age"
    t.boolean  "gender"
    t.string   "education"
    t.string   "id_no"
    t.string   "passport_no"
    t.string   "nationality"
    t.date     "birthday"
    t.string   "address"
    t.string   "phone_no"
    t.string   "mobile_no"
    t.string   "hashed_pw"
    t.string   "salt"
    t.integer  "identity"
    t.string   "verify_code"
    t.boolean  "verified",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
