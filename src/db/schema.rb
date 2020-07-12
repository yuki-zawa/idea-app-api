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

ActiveRecord::Schema.define(version: 2020_05_12_073636) do

  create_table "authorizations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "uid"
    t.string "provider"
    t.boolean "status", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider", "uid"], name: "index_authorizations_on_provider_and_uid", unique: true
    t.index ["user_id"], name: "index_authorizations_on_user_id"
  end

  create_table "genre_tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "color"
    t.boolean "status", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_genre_tags_on_user_id"
  end

  create_table "idea_genre_tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "idea_id", null: false
    t.bigint "genre_tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_tag_id"], name: "index_idea_genre_tags_on_genre_tag_id"
    t.index ["idea_id"], name: "index_idea_genre_tags_on_idea_id"
  end

  create_table "idea_idea_tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "idea_id", null: false
    t.bigint "idea_tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["idea_id"], name: "index_idea_idea_tags_on_idea_id"
    t.index ["idea_tag_id"], name: "index_idea_idea_tags_on_idea_tag_id"
  end

  create_table "idea_multi_ideas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "multi_idea_id", null: false
    t.bigint "idea_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["idea_id"], name: "index_idea_multi_ideas_on_idea_id"
    t.index ["multi_idea_id"], name: "index_idea_multi_ideas_on_multi_idea_id"
  end

  create_table "idea_tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.boolean "status", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_idea_tags_on_user_id"
  end

  create_table "ideas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "icon"
    t.string "title"
    t.text "detail"
    t.float "priority"
    t.boolean "status", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_ideas_on_user_id"
  end

  create_table "multi_ideas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "icon"
    t.string "title"
    t.text "detail"
    t.float "priority"
    t.boolean "status", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "remember_digest"
    t.string "activation_digest"
    t.datetime "activated_at"
    t.boolean "activated", default: false
    t.boolean "status", default: true
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["token"], name: "index_users_on_token", unique: true
  end

  add_foreign_key "authorizations", "users"
  add_foreign_key "genre_tags", "users"
  add_foreign_key "idea_genre_tags", "genre_tags"
  add_foreign_key "idea_genre_tags", "ideas"
  add_foreign_key "idea_idea_tags", "idea_tags"
  add_foreign_key "idea_idea_tags", "ideas"
  add_foreign_key "idea_multi_ideas", "ideas"
  add_foreign_key "idea_multi_ideas", "multi_ideas"
  add_foreign_key "idea_tags", "users"
  add_foreign_key "ideas", "users"
end
