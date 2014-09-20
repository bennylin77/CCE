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

ActiveRecord::Schema.define(version: 20140920034453) do

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
    t.integer  "tuition"
    t.text     "link"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.text     "lecturers"
    t.text     "class_time"
    t.text     "note"
    t.integer  "school_year"
    t.date     "start_at"
    t.date     "end_at"
    t.string   "requester"
    t.string   "organizer"
    t.string   "other_organizer"
    t.string   "host"
    t.integer  "host_extend"
    t.integer  "user_id"
    t.string   "location"
    t.integer  "grants",                        default: 0
    t.integer  "total_tuition"
    t.integer  "other_funds",                   default: 0
    t.integer  "user_size_limits"
    t.integer  "total_credits"
    t.integer  "total_hours"
    t.integer  "in_school_lecturers_quantity"
    t.integer  "out_school_lecturers_quantity"
    t.integer  "school_expenses",               default: 0
    t.integer  "academic_expenses",             default: 0
    t.integer  "center_expenses",               default: 0
    t.integer  "college_expenses",              default: 0
    t.integer  "department_expenses",           default: 0
    t.integer  "school_venue_fee",              default: 0
    t.integer  "units_venue_fee",               default: 0
    t.integer  "personnel_fee",                 default: 0
    t.integer  "sales_fee",                     default: 0
    t.integer  "travel_fee",                    default: 0
    t.integer  "facilities_fee",                default: 0
    t.integer  "hourly_fee",                    default: 0
    t.boolean  "verified",                      default: false
    t.integer  "verified_user_id"
    t.boolean  "available",                     default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cce_classes", ["user_id"], name: "index_cce_classes_on_user_id", using: :btree

  create_table "courses", force: true do |t|
    t.integer  "cce_class_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["cce_class_id"], name: "index_courses_on_cce_class_id", using: :btree

  create_table "dimensions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "edm_news", force: true do |t|
    t.integer  "edm_id"
    t.integer  "news_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "edm_news", ["edm_id"], name: "index_edm_news_on_edm_id", using: :btree
  add_index "edm_news", ["news_id"], name: "index_edm_news_on_news_id", using: :btree

  create_table "edms", force: true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "edms", ["user_id"], name: "index_edms_on_user_id", using: :btree

  create_table "news", force: true do |t|
    t.integer  "cce_class_id"
    t.integer  "user_id"
    t.string   "title"
    t.string   "link"
    t.text     "content"
    t.integer  "view",               default: 0
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.string   "DM_file_name"
    t.string   "DM_content_type"
    t.integer  "DM_file_size"
    t.datetime "DM_updated_at"
    t.boolean  "verified",           default: false
    t.integer  "verified_user_id"
    t.boolean  "available",          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "news", ["cce_class_id"], name: "index_news_on_cce_class_id", using: :btree
  add_index "news", ["user_id"], name: "index_news_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "extend"
    t.boolean  "gender",      default: true
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
    t.boolean  "edm",         default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
