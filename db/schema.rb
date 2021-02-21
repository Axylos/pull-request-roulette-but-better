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

ActiveRecord::Schema.define(version: 2021_02_14_205947) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "mail_messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.json "header", null: false
    t.text "body", null: false
    t.uuid "in_reply_to_id"
    t.uuid "in_reference_to_id"
    t.uuid "user_id"
    t.text "subject", null: false
    t.text "from", null: false
    t.text "to", null: false
    t.text "date", null: false
    t.text "message_id", null: false
    t.text "patch"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["in_reference_to_id"], name: "index_mail_messages_on_in_reference_to_id"
    t.index ["in_reply_to_id"], name: "index_mail_messages_on_in_reply_to_id"
    t.index ["user_id"], name: "index_mail_messages_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "gh_username"
  end

  add_foreign_key "mail_messages", "mail_messages", column: "in_reference_to_id"
  add_foreign_key "mail_messages", "mail_messages", column: "in_reply_to_id"
  add_foreign_key "mail_messages", "users"
end
