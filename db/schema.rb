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

ActiveRecord::Schema.define(version: 20161112041901) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "file_commands", force: :cascade do |t|
    t.integer "user_id"
    t.string  "file_id"
    t.string  "title"
    t.string  "mime_type"
    t.string  "parents"
    t.string  "statuses"
    t.string  "upload_source"
    t.string  "content_type"
  end

  create_table "google_id_pools", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "google_id_pools", ["user_id"], name: "index_google_id_pools_on_user_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.integer "user_id"
    t.string  "google_id"
    t.string  "text"
    t.string  "google_drive_id"
    t.string  "title"
  end

  create_table "pdfs", force: :cascade do |t|
    t.integer "user_id"
    t.string  "file_id"
    t.integer "project_id"
    t.string  "google_drive_id"
    t.string  "upload_source"
    t.string  "content_type"
    t.string  "title"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "google_drive_id"
  end

  create_table "sidekiq_jobs", force: :cascade do |t|
    t.string   "job_id"
    t.integer  "user_id"
    t.integer  "driveable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "driveable_type"
  end

  add_index "sidekiq_jobs", ["driveable_id", "driveable_type"], name: "index_sidekiq_jobs_on_driveable_id_and_driveable_type", using: :btree

  create_table "user_projects", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "access_token"
    t.string   "refresh_token"
    t.string   "password_digest"
    t.string   "email"
    t.string   "google_drive_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
  end

  add_foreign_key "images", "users"
end
