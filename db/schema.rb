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

ActiveRecord::Schema.define(version: 2023_05_01_211817) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer "experience_id"
    t.integer "user_id"
    t.integer "bookmarked", default: 0
    t.index ["experience_id"], name: "index_bookmarks_on_experience_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "experience_comments", force: :cascade do |t|
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
    t.string "title"
    t.string "location"
    t.string "street"
    t.string "city"
    t.string "postal_code"
    t.index ["program_id"], name: "index_experiences_on_program_id"
    t.index ["user_id"], name: "index_experiences_on_user_id"
  end

  create_table "flag_experiences", force: :cascade do |t|
    t.integer "flag"
    t.integer "user_id", null: false
    t.integer "experience_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "category"
    t.index ["experience_id"], name: "index_flag_experiences_on_experience_id"
    t.index ["user_id"], name: "index_flag_experiences_on_user_id"
  end

  create_table "flag_tips", force: :cascade do |t|
    t.integer "flag"
    t.integer "user_id", null: false
    t.integer "tip_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tip_id"], name: "index_flag_tips_on_tip_id"
    t.index ["user_id"], name: "index_flag_tips_on_user_id"
  end

  create_table "helpful_votes", force: :cascade do |t|
    t.integer "vote"
    t.integer "tip_id"
    t.integer "user_id"
    t.index ["tip_id"], name: "index_helpful_votes_on_tip_id"
    t.index ["user_id"], name: "index_helpful_votes_on_user_id"
  end

  create_table "participants", force: :cascade do |t|
    t.boolean "is_faculty"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "program_id"
    t.string "email"
    t.index ["program_id"], name: "index_participants_on_program_id"
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
    t.string "ban_reason"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookmarks", "experiences"
  add_foreign_key "bookmarks", "users"
  add_foreign_key "experience_comments", "experiences"
  add_foreign_key "experience_comments", "users"
  add_foreign_key "experiences", "programs"
  add_foreign_key "experiences", "users"
  add_foreign_key "flag_experiences", "experiences"
  add_foreign_key "flag_experiences", "users"
  add_foreign_key "flag_tips", "tips"
  add_foreign_key "flag_tips", "users"
  add_foreign_key "helpful_votes", "tips"
  add_foreign_key "helpful_votes", "users"
  add_foreign_key "participants", "programs"
  add_foreign_key "tips", "programs"
  add_foreign_key "tips", "users"
  add_foreign_key "users", "programs"
  add_foreign_key "yelp_locations", "experiences"
end
