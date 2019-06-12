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

ActiveRecord::Schema.define(version: 2019_06_12_163151) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
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

  create_table "ahoy_messages", force: :cascade do |t|
    t.string "user_type"
    t.bigint "user_id"
    t.text "to"
    t.string "mailer"
    t.text "subject"
    t.datetime "sent_at"
    t.index ["user_type", "user_id"], name: "index_ahoy_messages_on_user_type_and_user_id"
  end

  create_table "discount_codes", force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.integer "percent"
    t.integer "cents"
    t.text "valid_emails"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "limit"
    t.integer "times_used", default: 0
    t.boolean "is_active", default: true
    t.datetime "expiration_date"
    t.integer "registrations_count", default: 0
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string "short_description"
    t.text "overview_html"
    t.string "facebook_event_link"
    t.datetime "archived_at"
    t.string "archived_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "location_id"
    t.string "slug"
    t.text "schedule_html"
    t.text "details_html"
    t.text "video_embed_code"
    t.text "lodging_html"
    t.integer "registrations_count", default: 0
    t.boolean "is_active", default: true
    t.text "waiver_html"
    t.string "time_zone", default: "Central Time (US & Canada)"
    t.text "refund_policy_html"
    t.datetime "registration_opens_at"
    t.datetime "registration_closes_at"
    t.index ["location_id"], name: "index_events_on_location_id"
    t.index ["slug"], name: "index_events_on_slug", unique: true
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "gps_lat"
    t.string "gps_long"
    t.string "address_text"
    t.string "address_link"
    t.string "spectator_entry_fee_text"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "short_description"
    t.text "description_html"
    t.string "slug"
    t.string "external_website_link"
    t.index ["slug"], name: "index_locations_on_slug", unique: true
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "registration_id"
    t.bigint "race_id"
    t.string "first_name"
    t.string "last_name"
    t.string "division"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.string "medical_conditions"
    t.datetime "birth_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "emergency_contact_name"
    t.string "emergency_contact_phone"
    t.boolean "accepts_waiver"
    t.bigint "event_id"
    t.index ["event_id"], name: "index_participants_on_event_id"
    t.index ["race_id"], name: "index_participants_on_race_id"
    t.index ["registration_id"], name: "index_participants_on_registration_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "user_id"
    t.string "stripe_charge_id"
    t.string "stripe_customer_id"
    t.integer "amount_charged_in_cents"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "registration_id"
    t.index ["registration_id"], name: "index_payments_on_registration_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "races", force: :cascade do |t|
    t.bigint "event_id"
    t.string "name"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.boolean "is_active"
    t.datetime "registration_opens_at"
    t.datetime "archived_at"
    t.string "archived_by"
    t.string "strava_segment_link"
    t.text "strava_embed_code"
    t.text "course_description_text"
    t.string "short_description"
    t.text "overview_html"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_in_cents", default: 100
    t.string "slug"
    t.integer "participants_count", default: 0
    t.integer "participants_cap", default: 500
    t.index ["event_id"], name: "index_races_on_event_id"
    t.index ["slug"], name: "index_races_on_slug", unique: true
  end

  create_table "registrations", force: :cascade do |t|
    t.string "billing_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "event_id"
    t.string "starting_name"
    t.string "token"
    t.string "step_to_validate"
    t.datetime "started_at"
    t.string "status"
    t.datetime "completed_at"
    t.boolean "keep_private", default: true
    t.text "steps_seen"
    t.text "steps_completed"
    t.boolean "accepts_refund_terms"
    t.bigint "discount_code_id"
    t.index ["discount_code_id"], name: "index_registrations_on_discount_code_id"
    t.index ["event_id"], name: "index_registrations_on_event_id"
    t.index ["token"], name: "index_registrations_on_token", unique: true
  end

  create_table "series", force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.string "short_description"
    t.text "overview_html"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_active", default: true
  end

  create_table "sponsors", force: :cascade do |t|
    t.string "name"
    t.string "promo_html"
    t.string "promo_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "short_description"
  end

  create_table "team_members", force: :cascade do |t|
    t.string "name"
    t.text "bio_html"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "first_name"
    t.string "last_name"
    t.datetime "birth_date"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.string "medical_conditions"
    t.string "division"
    t.string "originating_registration_id"
    t.boolean "is_guest", default: false
    t.boolean "is_admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "events", "locations"
  add_foreign_key "participants", "events"
  add_foreign_key "participants", "races"
  add_foreign_key "participants", "registrations"
  add_foreign_key "payments", "registrations"
  add_foreign_key "payments", "users"
  add_foreign_key "races", "events"
  add_foreign_key "registrations", "discount_codes"
  add_foreign_key "registrations", "events"
end
