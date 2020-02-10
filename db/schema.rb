# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_10_021555) do

  create_table "programs", force: :cascade do |t|
    t.string "name"
    t.string "region"
    t.string "location"
    t.boolean "disabled", default: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string "business_id"
    t.string "user_email"
    t.text "comment"
    t.integer "rating"
    t.integer "price"
    t.integer "safety"
    t.integer "service"
    t.boolean "cash_only"
    t.boolean "english"
    t.boolean "tips"
    t.boolean "wifi"
    t.boolean "wheelchair"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "program_id"
    t.boolean "admin", default: false
    t.boolean "banned", default: false
    t.index ["program_id"], name: "index_users_on_program_id"
  end

  add_foreign_key "users", "programs"
end
