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

ActiveRecord::Schema.define(version: 2020_03_02_021015) do

  create_table "experience_comments", force: :cascade do |t|
    t.text "title"
    t.text "comment"
    t.integer "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "experience_id"
    t.integer "user_id"
    t.index ["experience_id"], name: "index_experience_comments_on_experience_id"
    t.index ["user_id"], name: "index_experience_comments_on_user_id"
  end

  create_table "experiences", force: :cascade do |t|
    t.text "experience"
    t.integer "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "program_id"
    t.integer "user_id"
    t.string "tags"
    t.index ["program_id"], name: "index_experiences_on_program_id"
    t.index ["user_id"], name: "index_experiences_on_user_id"
  end

  create_table "helpful_votes", force: :cascade do |t|
    t.integer "vote"
    t.integer "tip_id"
    t.integer "user_id"
    t.index ["tip_id"], name: "index_helpful_votes_on_tip_id"
    t.index ["user_id"], name: "index_helpful_votes_on_user_id"
  end

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

  create_table "tips", force: :cascade do |t|
    t.text "tip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "program_id"
    t.integer "user_id"
    t.index ["program_id"], name: "index_tips_on_program_id"
    t.index ["user_id"], name: "index_tips_on_user_id"
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

  create_table "yelp_locations", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "alias"
    t.string "yelp_id"
    t.string "url"
    t.string "image_url"
    t.string "rating"
    t.string "yelp_tags"
    t.integer "experience_id"
    t.index ["experience_id"], name: "index_yelp_locations_on_experience_id"
  end

  add_foreign_key "experience_comments", "experiences"
  add_foreign_key "experience_comments", "users"
  add_foreign_key "experiences", "programs"
  add_foreign_key "experiences", "users"
  add_foreign_key "helpful_votes", "tips"
  add_foreign_key "helpful_votes", "users"
  add_foreign_key "tips", "programs"
  add_foreign_key "tips", "users"
  add_foreign_key "users", "programs"
  add_foreign_key "yelp_locations", "experiences"
end
