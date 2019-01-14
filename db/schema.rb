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

ActiveRecord::Schema.define(version: 2019_01_14_201310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string "short_description"
    t.text "long_description"
    t.string "facebook_event_link"
    t.string "external_photo_link"
    t.string "external_results_link"
    t.string "external_reservations_link"
    t.string "is_active"
    t.datetime "archived_at"
    t.string "archived_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "gps_lat"
    t.string "gps_long"
    t.string "address_text"
    t.string "address_link"
    t.boolean "allows_dogs"
    t.string "spectator_entry_fee_text"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "short_description"
    t.text "long_description"
    t.text "website_link"
  end

  create_table "races", force: :cascade do |t|
    t.bigint "event_id"
    t.string "name"
    t.integer "distance"
    t.string "distance_type"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.boolean "is_active"
    t.datetime "registration_opens_at"
    t.datetime "archived_at"
    t.string "archived_by"
    t.string "course_map_link"
    t.text "course_map_embed_code"
    t.text "course_description_text"
    t.string "short_description"
    t.string "long_description"
    t.text "video_embed_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_races_on_event_id"
  end

  create_table "registrations", force: :cascade do |t|
    t.bigint "race_id"
    t.string "first_name"
    t.string "last_name"
    t.datetime "date_of_birth"
    t.string "email"
    t.string "division"
    t.string "mobile_phone"
    t.boolean "opted_in_for_communication"
    t.string "emergency_contact_name"
    t.string "emergency_contact_phone"
    t.text "medical_conditions_description"
    t.string "legal_guardian_name"
    t.string "legal_guardian_phone_string"
    t.string "legal_guardian_initials"
    t.boolean "accepted_refund_policy"
    t.boolean "accepted_waiver"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["race_id"], name: "index_registrations_on_race_id"
  end

  add_foreign_key "races", "events"
  add_foreign_key "registrations", "races"
end
