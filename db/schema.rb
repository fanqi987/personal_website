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

ActiveRecord::Schema.define(version: 20190626135503) do

  create_table "comments", force: :cascade do |t|
    t.string "commentable_type"
    t.integer "commentable_id"
    t.string "user_name", null: false
    t.integer "user_id"
    t.text "content", null: false
    t.integer "like", default: 0
    t.string "email"
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  end

  create_table "diaries", force: :cascade do |t|
    t.integer "user_id"
    t.string "title", null: false
    t.string "content", null: false
    t.integer "like", default: 0
    t.integer "read", default: 0
    t.boolean "draft", default: true
    t.datetime "modified_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_diaries_on_user_id"
  end

  create_table "hobbies", force: :cascade do |t|
    t.integer "user_id"
    t.string "title", null: false
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_hobbies_on_user_id"
  end

  create_table "hobby_items", force: :cascade do |t|
    t.integer "hobby_id"
    t.integer "user_id", null: false
    t.string "title", null: false
    t.string "content"
    t.string "image", null: false
    t.boolean "cover", default: false
    t.integer "like", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hobby_id"], name: "index_hobby_items_on_hobby_id"
  end

  create_table "likes", force: :cascade do |t|
    t.string "likeable_type"
    t.integer "likeable_id"
    t.integer "user_id"
    t.string "user_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id"
  end

  create_table "materials", force: :cascade do |t|
    t.integer "user_id"
    t.string "title", null: false
    t.string "content", null: false
    t.string "material_type", null: false
    t.string "href", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_materials_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "microposts", force: :cascade do |t|
    t.integer "user_id"
    t.text "content", null: false
    t.string "picture"
    t.string "video"
    t.integer "like", default: 0
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_microposts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.string "remember_digest"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "avatar", default: "0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
  end

end
