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

ActiveRecord::Schema.define(version: 20161017211207) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaigns", force: :cascade do |t|
    t.string   "label"
    t.date     "date"
    t.text     "note"
    t.integer  "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date"], name: "index_campaigns_on_date", using: :btree
    t.index ["label"], name: "index_campaigns_on_label", using: :btree
  end

  create_table "donations", force: :cascade do |t|
    t.date     "date"
    t.integer  "person_id"
    t.integer  "campaign_id"
    t.integer  "amount_cents"
    t.string   "donation_type"
    t.integer  "created_by"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["amount_cents"], name: "index_donations_on_amount_cents", using: :btree
    t.index ["campaign_id"], name: "index_donations_on_campaign_id", using: :btree
    t.index ["date"], name: "index_donations_on_date", using: :btree
    t.index ["donation_type"], name: "index_donations_on_donation_type", using: :btree
    t.index ["person_id"], name: "index_donations_on_person_id", using: :btree
  end

  create_table "people", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "business_name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone_1"
    t.string   "phone_2"
    t.string   "solicitor"
    t.integer  "created_by"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "email"
    t.index ["business_name"], name: "index_people_on_business_name", using: :btree
    t.index ["first_name"], name: "index_people_on_first_name", using: :btree
    t.index ["last_name"], name: "index_people_on_last_name", using: :btree
    t.index ["solicitor"], name: "index_people_on_solicitor", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "login"
    t.string   "password_digest"
    t.boolean  "active",          default: true, null: false
    t.integer  "created_by"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["login", "active"], name: "index_users_on_login_and_active", using: :btree
    t.index ["login"], name: "index_users_on_login", using: :btree
    t.index ["password_digest"], name: "index_users_on_password_digest", using: :btree
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree
  end

end
